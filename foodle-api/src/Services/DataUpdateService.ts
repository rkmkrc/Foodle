import path from "path";
import fs from "fs";

export const uploadReviewPhoto = async (data: string, id: string, photoName: string) => {
    console.log(photoName)
    return await uploadData(data, './public/reviews', id, photoName);
}

export const uploadUserPhoto = async (data: string, id: string) => {
    return await uploadData(data, './public/users', id, 'profile_photo.jpg');
}

const uploadData = async (data: string, dataPath: string, id: string, fileName: string) => {
    const photoData = Buffer.from(data, 'base64');
    const relativePath = path.resolve(dataPath);
    let result = 200;
    let resultMessage;
    fs.mkdir(
        path.join(relativePath, id),
        { recursive: true },
        (err) => {
            if (err !== null && (err.code as string) !== 'EEXIST') {
                result = 500;
                resultMessage = { message: err };
            }
        }
    );

    fs.writeFile(
        path.join(relativePath, id, fileName),
        photoData,
        (err) => {
            if (err !== null) {
                result = 500;
                resultMessage = { message: err };
            }
        }
    );
    return { result: result, resultMessage: resultMessage }
}