FROM node:slim

WORKDIR /opt/app

COPY package.json /opt/app/package.json
RUN npm install

COPY app.js /opt/app/app.js

ENTRYPOINT ["npm", "run" ]
CMD ["start"]