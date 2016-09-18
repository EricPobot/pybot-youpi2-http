# -*- coding: utf-8 -*-

import httplib

from bottle import HTTPError, request, response, error

from pybot.youpi2.model import YoupiArm
from pybot.youpi2.app import ArmError

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

    def _http_404(self, what):
        response.status = '404 Not Found: %s' % what
        self.log_error(response.status)
        return {"what": what}

    @staticmethod
    def _pythonize_values_dict(d):
        return {
            k: float(v) for k, v in d.iteritems()
        }

    def _handle_armerror(self, e):
        reason = e.message.strip().splitlines()[-1]
        self.log_warning(reason)
        response.status = httplib.BAD_REQUEST
        return {"reason": reason}

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
            return self._http_404(str(e).split()[0])

        if pose:
            try:
                self.arm.goto(pose, True)
            except ArmError as e:
                return self._handle_armerror(e)
            else:
                response.status = httplib.NO_CONTENT
        else:
            return HTTPError(httplib.BAD_REQUEST, 'No pose provided')

    def move(self):
        try:
            angles = {YoupiArm.MOTOR_NAMES.index(j): float(a) for j, a in request.query.iteritems()}
        except ValueError as e:
            return self._http_404(str(e).split()[0])

        if angles:
            try:
                self.arm.move(angles, True)
            except ArmError as e:
                return self._handle_armerror(e)
            else:
                response.status = httplib.NO_CONTENT
        else:
            return HTTPError(httplib.BAD_REQUEST, 'No angle provided')

    def get_joint_angle(self, joint):
        try:
            joint_id = int(joint)
        except ValueError:
            try:
                joint_id = YoupiArm.MOTOR_NAMES.index(joint)
            except ValueError:
                return self._http_404(joint)

        try:
            position = float(self.arm.get_joint_positions()[joint_id])
        except IndexError:
            return self._http_404(joint_id)
        else:
            return {'angle': position}

    def set_joint_angle(self, joint):
        try:
            joint_id = int(joint)
        except ValueError:
            try:
                joint_id = YoupiArm.MOTOR_NAMES.index(joint)
            except ValueError:
                return self._http_404(joint)

        angle = request.query.angle
        if angle:
            try:
                self.arm.goto({joint_id: float(angle)}, True)
            except ArmError as e:
                return self._handle_armerror(e)
            else:
                response.status = httplib.NO_CONTENT
        else:
            return HTTPError(400, 'Missing argument: angle ')

    def get_motor_positions(self):
        return {
            YoupiArm.MOTOR_NAMES[k]: float(v) for k, v in enumerate(self.arm.get_motor_positions())
        }

    def set_motor_positions(self):
        try:
            positions = {YoupiArm.MOTOR_NAMES.index(j): float(a) for j, a in request.query.iteritems()}
        except ValueError as e:
            return self._http_404(str(e).split()[0])

        if positions:
            try:
                self.arm.motor_goto(positions, True)
            except ArmError as e:
                return self._handle_armerror(e)
            else:
                response.status = httplib.NO_CONTENT
        else:
            return HTTPError(httplib.BAD_REQUEST, 'No motor position provided')

    def get_motor_position(self, motor):
        try:
            joint_id = int(motor)
        except ValueError:
            try:
                joint_id = YoupiArm.MOTOR_NAMES.index(motor)
            except ValueError:
                return self._http_404(motor)

        try:
            position = float(self.arm.get_motor_positions()[joint_id])
        except IndexError:
            return self._http_404(joint_id)
        else:
            return {'position': position}

    def set_motor_position(self, motor):
        try:
            joint_id = int(motor)
        except ValueError:
            try:
                joint_id = YoupiArm.MOTOR_NAMES.index(motor)
            except ValueError:
                return self._http_404(motor)

        position = request.query.position
        if position:
            try:
                self.arm.motor_goto({joint_id: float(position)}, True)
            except ArmError as e:
                return self._handle_armerror(e)
            else:
                response.status = httplib.NO_CONTENT
        else:
            return HTTPError(httplib.BAD_REQUEST, 'Missing argument: position')

    def go_home(self):
        self.arm.go_home([m for m in YoupiArm.MOTORS_ALL if m != YoupiArm.MOTOR_GRIPPER], True)
        response.status = httplib.NO_CONTENT

    def hi_z(self):
        self.arm.soft_hi_Z()
        response.status = httplib.NO_CONTENT

    def set_gripper_state(self):
        if int(request.query.opened):
            self.arm.open_gripper(True)
        else:
            self.arm.close_gripper(True)

        response.status = httplib.NO_CONTENT

    def calibrate(self):
        self.arm.seek_origins(YoupiArm.MOTORS_ALL)
        self.arm.calibrate_gripper(True)
        response.status = httplib.NO_CONTENT
