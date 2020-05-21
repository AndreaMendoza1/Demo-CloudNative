const { Client } = require("pg");

function main(params) {
    let caCert = new Buffer.from(
        "",
        "base64"
    ).toString();

    const client = new Client({
        host:
            "",
        port: 30508,
        user: "mparedes",
        password: "PasswordDemo",
        database: "ibmclouddb",
        ssl: {
            ca: caCert
        }
    });
    
    client.connect();
    
    let _query = `select * from test;`;
     
   return client.query(_query).then(response => {
        client.end();
        var items = [];
        response.rows.forEach((item, index) => {
            items.push([
                { "data": item.id },
                { "data": item.image }
            ]);
        });
        
        const headers = [
            {"data":"Id"},
            {"data":"image"}
        ];
        
        return {
            statusCode: 200,
            headers: { 'Content-Type': 'application/json' },
            body: { headers: headers,data: items, images: response.rows, status: true }
        };
    })
    .catch(err => {
        client.end();
        return {
            statusCode: 301,
            headers: { 'Content-Type': 'application/json' },
            body: { status: false, err: err }
        };
    });
}