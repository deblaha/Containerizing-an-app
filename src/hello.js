const express = require('express');

const application = express();
const port = 5000;

application.get('/', (req,res) => {
    res.send('Hello World!');
});

application.listen(port, () => {
    console.log(`Server listening on port ${port}`);
});