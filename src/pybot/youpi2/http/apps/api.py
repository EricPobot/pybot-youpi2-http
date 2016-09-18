# -*- coding: utf-8 -*-

from bottle import HTTPError, request

from pybot.youpi2.model import YoupiArm

from pybot.youpi2.http.base import YoupiBottleApp
from pybot.youpi2.http.__version__ import version

__author__ = 'Eric Pascual'


class RestAPIApp(YoupiBottleApp):
    def __init__(self, *args, **kwargs):
        super(RestAPIApp, self).__init__(*args, **kwargs)

        self.route('/version', 'GET', callback=self.get_version)
        self.route('/settings', 'GET', callback=self.get_settings)
        self.route('/pose', 'GET', callback=self.get_pose)
        self.route('/pose', 'PUT', callback=self.set_pose)
        self.route('/position/<joint>', 'GET', callback=self.get_joint_position)
        self.route('/position/<joint>', 'PUT', callback=self.set_joint_position)
        self.route('/gripper', 'PUT', callback=self.set_gripper_state)
        self.route('/home', 'PUT', callback=self.go_home)
        self.route('/hi_z', 'PUT', callback=self.hi_z)
        self.route('/calibrate', 'PUT', callback=self.calibrate)

    def _http_error(self, status, msg):
        self.log_error(msg)
        return HTTPError(status, msg)

    def get_version(self):
        return {'version': version}

    def get_settings(self):
        return {
            YoupiArm.MOTOR_NAMES[j]: s for j, s in enumerate(self.arm.get_settings())
        }

    def get_pose(self):
        return {YoupiArm.MOTOR_NAMES[j]: float(p) for j, p in enumerate(self.arm.get_current_positions())}

    def set_pose(self):
        try:
            pose = {YoupiArm.MOTOR_NAMES.index(j): float(a) for j, a in request.query.iteritems()}
        except ValueError as e:
            return self._http_error(404, 'joint name not found (%s)' % str(e).split()[0])

        self.arm.goto(pose, True)

    def get_joint_position(self, joint):
        try:
            joint_id = int(joint)
        except ValueError:
            try:
                joint_id = YoupiArm.MOTOR_NAMES.index(joint)
            except ValueError:
                return self._http_error(404, 'joint name not found (%s)' % joint)

        try:
            position = float(self.arm.get_current_positions()[joint_id])
        except IndexError:
            return self._http_error(404, 'joint id not found (%d)' % joint_id)
        else:
            return {'position': position}

    def set_joint_position(self, joint):
        try:
            joint_id = int(joint)
        except ValueError:
            try:
                joint_id = YoupiArm.MOTOR_NAMES.index(joint)
            except ValueError:
                return self._http_error(404, 'joint name not found (%s)' % joint)

        self.arm.goto({joint_id: float(request.query.pos)}, True)

    def go_home(self):
        self.arm.go_home([m for m in YoupiArm.MOTORS_ALL if m != YoupiArm.MOTOR_GRIPPER], True)

    def hi_z(self):
        self.arm.soft_hi_Z()

    def set_gripper_state(self):
        if int(request.query.opened):
            self.arm.open_gripper(True)
        else:
            self.arm.close_gripper(True)

    def calibrate(self):
        self.arm.seek_origins(YoupiArm.MOTORS_ALL)
        self.arm.calibrate_gripper(True)
