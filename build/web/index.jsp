<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">        
        <title>Consultar RUC</title>
        <script>

            function obtener() {
                //var RUC = '20521586134';
                var RUC = document.getElementById('idRuc').value;
                var TOKEN = 'ba0e4916e6d3c0ee7b2e0ba8ddf1327a6ef8e8e6ca2e2b929bbe25b5203c2d41';
                if (RUC === '' || RUC.length !== 11)
                    alert('Código RUC incorrecto!');
                else
                    cargarRucs(RUC, TOKEN);
            }

            async function cargarRucs(ruc, token) {
                const request = await fetch('https://apiperu.dev/api/ruc/' + ruc + '?api_token=' + token, {
                    method: 'GET',
                    headers: getHeaders()
                });
                //console.log(await request.json());
                const documento = await request.json();
                let listadoHtml = '';
                let documentoHtml = '<tr><td>'
                        + documento.data.ruc + '</td><td>'
                        + documento.data.nombre_o_razon_social + '</td><td>'
                        + documento.data.direccion + '</td><td>'
                        + documento.data.departamento + '</td><td>'
                        + documento.data.provincia + '</td><td>'
                        + documento.data.distrito + '</td><td>'
                        + documento.data.direccion_completa +
                        '</td></tr>';
                listadoHtml += documentoHtml;

                document.querySelector('#documento tbody').outerHTML = listadoHtml;
            }

            function getHeaders() {
                return {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                    'Authorization': localStorage.token
                };
            }
        </script>
    </head>
    <body>                
        <div class="container"> 
            <div class="jumbotron"> 
                <h1 class="display-4" style="margin-top: 20px">Consultar RUC</h1>               
                <hr class="my-4">
            </div>
            <form name="form1" style="margin-bottom: 50px" >
                <div class="form-group">
                    <label for="codigo">Ingrese un número de RUC:  </label>
                    <label for="ejemplo" style="color: silver">(ejm. 20100053455, 20389230724, 20100070970, 20100128056, etc..)</label>                    
                    <p></p>
                    <div class="input-group mb-3" style="width: 300px;">
                        <input type="text" class="form-control" id="idRuc">
                        <button type="button" class="btn btn-success" onclick="obtener()">consultar</button>
                    </div>
                </div>                
            </form>                                             
            <table class="table table-bordered" id="documento" width="100%" cellspacing="0">
                <thead>
                    <tr>
                        <th>RUC</th>
                        <th>Razón Social</th>
                        <th>Dirección</th>
                        <th>Departamento</th>
                        <th>Provincia</th>
                        <th>Distrito</th>
                        <th>Dirección completa</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>