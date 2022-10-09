import pgPromise from 'pg-promise';
import dotenv from 'dotenv';
dotenv.config({ path: './config.env' });
const pgp = pgPromise({});

const postgreDB = pgp(String(process.env.SQL_ADDRESS));

export async function startPostgre() {
	try {
		await postgreDB.connect();
	} catch (err) {
		console.log(err);
	}
	console.log('[POSTGRE]: Postgre connected successfully.');
}

export default postgreDB;
