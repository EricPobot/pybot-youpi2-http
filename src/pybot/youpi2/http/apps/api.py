# -*- coding: utf-8 -*-

import httplib

from bottle import HTTPError, request, response

from pybot.youpi2.model import YoupiArm, OutOfBoundError

from pybot.youpi2.http.base import YoupiBottleApp
from pybot.youpi2.http.__version__ import version

__author__ = 'Eric Pascual'


class RestAPIApp(YoupiBottleApp):
    """ REST API for controlling the arm.
    """
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
        self.route('/ik', 'PUT', callback=self.ik)

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

    def _checked_move_command(self, meth, *args, **kwargs):
        try:
            meth(*args, **kwargs)
        except OutOfBoundError as e:
            self.log_warning(e.message)
            response.status = httplib.BAD_REQUEST
            return {"reason": e.message}
        else:
            response.status = httplib.NO_CONTENT

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
            pose = {YoupiArm.motor_id(joint_name): float(angle) for joint_name, angle in request.query.iteritems()}
        except ValueError as e:
            return self._http_404(str(e).split()[0])

        if pose:
            return self._checked_move_command(self.arm.goto, pose)
        else:
            return HTTPError(httplib.BAD_REQUEST, 'No pose provided')

    def move(self):
        try:
            angles = {YoupiArm.motor_id(joint_name): float(angle) for joint_name, angle in request.query.iteritems()}
        except ValueError as e:
            return self._http_404(str(e).split()[0])

        if angles:
            return self._checked_move_command(self.arm.move, angles)
        else:
            return HTTPError(httplib.BAD_REQUEST, 'No angle provided')

    def get_joint_angle(self, joint):
        try:
            joint_id = int(joint)
        except ValueError:
            try:
                joint_id = YoupiArm.motor_id(joint)
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
                joint_id = YoupiArm.motor_id(joint)
            except ValueError:
                return self._http_404(joint)

        angle = request.query.angle
        if angle:
            return self._checked_move_command(self.arm.goto, {joint_id: float(angle)})
        else:
            return HTTPError(400, 'Missing argument: angle ')

    def get_motor_positions(self):
        return {
            YoupiArm.MOTOR_NAMES[k]: float(v) for k, v in enumerate(self.arm.get_motor_positions())
        }

    def set_motor_positions(self):
        try:
            positions = {YoupiArm.motor_id(joint_name): float(angle) for joint_name, angle in request.query.iteritems()}
        except ValueError as e:
            return self._http_404(str(e).split()[0])

        if positions:
            return self._checked_move_command(self.arm.motor_goto, positions)
        else:
            return HTTPError(httplib.BAD_REQUEST, 'No motor position provided')

    def get_motor_position(self, motor):
        try:
            joint_id = int(motor)
        except ValueError:
            try:
                joint_id = YoupiArm.motor_id(motor)
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
                joint_id = YoupiArm.motor_id(motor)
            except ValueError:
                return self._http_404(motor)

        position = request.query.position
        if position:
            return self._checked_move_command(self.arm.motor_goto, {joint_id: float(position)})
        else:
            return HTTPError(httplib.BAD_REQUEST, 'Missing argument: position')

    def go_home(self):
        self.arm.go_home([m for m in YoupiArm.MOTORS_ALL if m != YoupiArm.MOTOR_GRIPPER])
        response.status = httplib.NO_CONTENT

    def hi_z(self):
        self.arm.soft_hi_Z()
        response.status = httplib.NO_CONTENT

    def set_gripper_state(self):
        if int(request.query.opened):
            self.arm.open_gripper()
        else:
            self.arm.close_gripper()

        response.status = httplib.NO_CONTENT

    def calibrate(self):
        self.arm.seek_origins(YoupiArm.MOTORS_ALL)
        self.arm.calibrate_gripper()
        response.status = httplib.NO_CONTENT

    def ik(self, x, y, z, pitch=90):
        return self._checked_move_command(self.arm.move_gripper_at, x, y, z, pitch)
