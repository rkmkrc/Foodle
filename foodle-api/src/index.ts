import startRedis from '#RedisHelper/RedisHelper';
import restaurantRouter from '#Controllers/Restaurant/index';
import userRouter from '#Controllers/User/index';
import express from 'express';
import { apiLogger, authController } from '#Middlewares/Auth';
import dotenv from 'dotenv';
import { startPostgre } from '#SqlHelper/index';
import userAuthRouter from '#Controllers/Authorization';
import path from 'path';
dotenv.config({ path: './config.env' });

const app = express();
app.use(express.json({ limit: '2mb' }));

app.use(apiLogger);

app.use('/user', authController, userRouter);
app.use('/restaurant', authController, restaurantRouter);
app.use('/auth', userAuthRouter);

app.use(express.static(path.join('./', 'public')));

app.listen(3000, async () => {
	await startRedis();
	await startPostgre();
	console.log('Foodle-api server is listening on 3000');
});
