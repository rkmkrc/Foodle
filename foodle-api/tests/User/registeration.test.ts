import Chance from 'chance';
import console from 'console';
const chance = new Chance();
import startRedis, {
	redisGetValue,
	stopRedis,
} from '../../src/Database/RedisHelper/RedisHelper';
import { baseURL, fetcher } from '../Constants';

describe('Should register properly and can login', () => {
	const userName = chance.name();
	const email = chance.email();
	it('should get OTP', async () => register(userName, email));

	it('should type OTP and register successfully', async () => {
		await confirmOTP(userName);
	});

	it('should try to login and get OTP', async () => {
		const data = await fetcher(`${baseURL}/auth/login`, {
			method: 'POST',
			body: JSON.stringify({
				userCredentials: {
					userName,
					hashedPassword: '123',
				},
			}),
		});
		expect(data.message).toEqual('OTP has been sent.');
	});

	it('should login with OTP', async () => {
		await confirmOTP(userName);
	});
});

describe('Failure register', () => {
	const userName = chance.name();
	const email = chance.email();
	it('should get OTP', async () => await register(userName, email));

	it('should type OTP wrong and get an error message', async () => {
		const data = await fetcher(`${baseURL}/auth/login?action=confirmOTP`, {
			method: 'POST',
			body: JSON.stringify({
				userCredentials: {
					userName,
					hashedPassword: '123',
					OTP: '11111',
				},
			}),
		});

		expect(data.message).toEqual('Wrong OTP');
	});
});

const register = async (userName: string, email: string) => {
	const data = await fetcher(`${baseURL}/auth/register`, {
		method: 'POST',
		body: JSON.stringify({
			userCredentials: {
				userName,
				hashedPassword: '123',
				email,
			},
		}),
	});
	expect(data).toEqual({
		status: true,
		message: 'OTP has been sent.',
	});
};

const confirmOTP = async (userName: string) => {
	await startRedis();
	await new Promise((r) => setTimeout(r, 2000));
	const otp = await redisGetValue(`${userName}_otp`);

	const data = await fetcher(`${baseURL}/auth/login?action=confirmOTP`, {
		method: 'POST',
		body: JSON.stringify({
			userCredentials: {
				userName,
				hashedPassword: '123',
				OTP: otp,
			},
		}),
	});

	expect(data.message).toEqual('User login successful.');
	await stopRedis();
};
