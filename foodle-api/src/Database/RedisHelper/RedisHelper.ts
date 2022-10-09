import { createClient } from 'redis';

const client = createClient({
	url: process.env.REDIS_ADDRESS,
});

export default async function startRedis() {
	await client.connect();
	console.log('[REDIS]: Redis connected.');
}

export async function stopRedis() {
	await client.disconnect();
}

client.on('error', (err) => console.log('Redis Client Error', err));

export const redisSetKey = async (key: string, value: string, duration?: number) => {
	const result = await client.set(key, value, {
		EX: duration, // seconds
		NX: true,
	});
	return result != null;
};

export const redisGetValue = async (key: string) => {
	const result = await client.get(key);

	return result;
};

export const redisDeleteKey = async (key: string) => {
	const result = await client.del(key);
	return result != 0;
};
