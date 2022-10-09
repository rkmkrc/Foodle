import { Router } from 'express';
import restaurantController from './RestaurantController';
import reviewController from './ReviewController';

const restaurantRouter = Router();

restaurantRouter.use('/', restaurantController);
restaurantRouter.use('/review', reviewController);

export default restaurantRouter;
