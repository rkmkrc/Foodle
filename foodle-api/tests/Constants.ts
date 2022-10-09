export const baseURL = 'http://localhost:3000';
export const fetcher = async (input: RequestInfo, init?: RequestInit) =>
	(
		await fetch(input, {
			...init,
			headers: {
				...init.headers,
				'Content-Type': 'application/json',
			},
		})
	).json();
