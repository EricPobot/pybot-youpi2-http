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
        self.route('/move', 'PUT', callback=self.move)
        self.route('/joint/<joint>', 'GET', callback=self.get_joint_angle)
        self.route('/joint/<joint>', 'PUT', callback=self.set_joint_angle)
        self.route('/gripper', 'PUT', callback=self.set_gripper_state)
        self.route('/motors', 'GET', callback=self.get_motor_positions)
        self.route('/motors', 'PUT', callback=self.set_motor_positions)
        self.route('/motor/<motor>', 'GET', callback=self.get_motor_position)
        self.route('/motor/<motor>', 'PUT', callback=self.set_motor_position)
        self.route('/home', 'PUT', callback=self.go_home)
        self.route('/hi_z', 'PUT', callback=self.hi_z)
        self.route('/calibrate', 'PUT', callback=self.calibrate)

    def _http_error(self, status, msg):
        self.log_error(msg)
        return HTTPError(status, msg)

    @staticmethod
    def _pythonize_values_dict(d):
        return {
            k: float(v) for k, v in d.iteritems()
        }

    def get_version(self):
        return {'version': version}

    def get_settings(self):
        return {
            j: self._pythonize_values_dict(s) for j, s in self.arm.get_settings().iteritems()
        }

    def get_pose(self):
        return {
            YoupiArm.MOTOR_NAMES[k]: float(v) for k, v in enumerate(self.arm.get_joint_positions())
        }

    def set_pose(self):
        try:
            pose = {YoupiArm.MOTOR_NAMES.index(j): float(a) for j, a in request.query.iteritems()}
        except ValueError as e:
            return self._http_error(404, 'joint name not found (%s)' % str(e).split()[0])

        if pose:
            self.arm.goto(pose, True)
        else:
            return HTTPError(400, 'missing pose settings')

    def move(self):
        try:
            angles = {YoupiArm.MOTOR_NAMES.index(j): float(a) for j, a in request.query.iteritems()}
        except ValueError as e:
            return self._http_error(404, 'joint name not found (%s)' % str(e).split()[0])

        if angles:
            self.arm.move(angles, True)
        else:
            return HTTPError(400, 'missing angles settings')

    def get_joint_angle(self, joint):
        try:
            joint_id = int(joint)
        except ValueError:
            try:
                joint_id = YoupiArm.MOTOR_NAMES.index(joint)
            except ValueError:
                return self._http_error(404, 'joint name not found (%s)' % joint)

        try:
            position = float(self.arm.get_joint_positions()[joint_id])
        except IndexError:
            return self._http_error(404, 'joint id not found (%d)' % joint_id)
        else:
            return {'angle': position}

    def set_joint_angle(self, joint):
        try:
            joint_id = int(joint)
        except ValueError:
            try:
                joint_id = YoupiArm.MOTOR_NAMES.index(joint)
            except ValueError:
                return self._http_error(404, 'joint name not found (%s)' % joint)

        angle = request.query.angle
        if angle:
            self.arm.goto({joint_id: float(angle)}, True)
        else:
            return HTTPError(400, 'missing angle argument')

    def get_motor_positions(self):
        return {
            YoupiArm.MOTOR_NAMES[k]: float(v) for k, v in enumerate(self.arm.get_motor_positions())
        }

    def set_motor_positions(self):
        try:
            positions = {YoupiArm.MOTOR_NAMES.index(j): float(a) for j, a in request.query.iteritems()}
        except ValueError as e:
            return self._http_error(404, 'motor name not found (%s)' % str(e).split()[0])

        if positions:
            self.arm.motor_goto(positions, True)
        else:
            return HTTPError(400, 'missing motors settings')

    def get_motor_position(self, motor):
        try:
            joint_id = int(motor)
        except ValueError:
            try:
                joint_id = YoupiArm.MOTOR_NAMES.index(motor)
            except ValueError:
                return self._http_error(404, 'motor name not found (%s)' % motor)

        try:
            position = float(self.arm.get_motor_positions()[joint_id])
        except IndexError:
            return self._http_error(404, 'motor id not found (%d)' % joint_id)
        else:
            return {'position': position}

    def set_motor_position(self, motor):
        try:
            joint_id = int(motor)
        except ValueError:
            try:
                joint_id = YoupiArm.MOTOR_NAMES.index(motor)
            except ValueError:
                return self._http_error(404, 'motor name not found (%s)' % motor)

        position = request.query.position
        if position:
            self.arm.motor_goto({joint_id: float(position)}, True)
        else:
            return HTTPError(400, 'missing position argument')

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
