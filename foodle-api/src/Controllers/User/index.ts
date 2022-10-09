import { Router } from 'express';
import userLogoutController from './Logout';
import userProfileController from './UserProfileController';

const userRouter = Router();

userRouter.use('/', userProfileController);
userRouter.use('/', userLogoutController);

export default userRouter;
