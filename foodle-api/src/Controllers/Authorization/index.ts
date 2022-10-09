import { Router } from 'express';
import userAuthCheckController from './CheckAuth';
import userLoginController from './Login';
import userRegisterController from './Register';

const userAuthRouter = Router();

userAuthRouter.use(userLoginController);
userAuthRouter.use(userRegisterController);
userAuthRouter.use(userLoginController);
userAuthRouter.use(userAuthCheckController);

export default userAuthRouter;
