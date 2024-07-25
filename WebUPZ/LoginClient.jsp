<%-- 
    Document   : LoginClient
    Created on : Jul 17, 2024, 8:19:56 PM
    Author     : User
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login Page</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"> <!-- Include Font Awesome -->
        <style>
            @import url('https://fonts.googleapis.com/css?family=Poppins:400,500,600,700,800,900');

            :root {
                --bg-color: #2a2b38;
                --text-color: #c4c3ca;
                --input-bg-color: #1f2029;
                --input-icon-color: #ffeba7;
                --btn-bg-color: #FED070;
                --btn-text-color: white;
                --btn-hover-bg-color: #E2D6C8;
                --btn-hover-text-color: black;
            }

            body {
                font-family: 'Poppins', sans-serif;
                font-weight: 300;
                font-size: 15px;
                line-height: 1.7;
                color: var(--text-color);
                background-image: url('./img/BGupz.jpg');
                background-size: cover;
                background-position: center;
                background-attachment: fixed;
                overflow-x: hidden;
            }
            a {
                cursor: pointer;
                transition: all 200ms linear;
            }
            a:hover {
                text-decoration: none;
            }
            .link {
                color: var(--text-color);
            }
            .link:hover {
                color: #ffeba7;
            }
            p {
                font-weight: 500;
                font-size: 14px;
                line-height: 1.7;
            }
            h3 {
                font-weight: 600;
            }
            h6 span {
                padding: 0 20px;
                text-transform: uppercase;
                font-weight: 700;
            }
            .section {
                position: relative;
                width: 100%;
                display: block;
            }
            .full-height {
                min-height: 100vh;
            }
            [type="checkbox"]:checked,
            [type="checkbox"]:not(:checked) {
                position: absolute;
                left: -9999px;
            }
            .checkbox:checked + label,
            .checkbox:not(:checked) + label {
                position: relative;
                display: block;
                text-align: center;
                width: 60px;
                height: 30px;
                border-radius: 15px;
                padding: 0;
                margin: 10px auto;
                cursor: pointer;
                background-color: #FDB46C;
                transition: background-color 0.5s ease;
            }
            .checkbox:checked + label:before,
            .checkbox:not(:checked) + label:before {
                position: absolute;
                display: block;
                width: 24px;
                height: 24px;
                border-radius: 50%;
                top: 3px;
                left: 3px;
                content: '\f185';
                font-family: 'Font Awesome 5 Free';
                font-weight: 900;
                line-height: 24px;
                text-align: center;
                background-color: black;
                color: white;
                transition: transform 0.5s ease;
            }
            .checkbox:checked + label:before {
                transform: translateX(30px);
                content: '\f186';
            }

            .card-3d-wrap {
                position: relative;
                width: 440px;
                max-width: 100%;
                height: 400px;
                -webkit-transform-style: preserve-3d;
                transform-style: preserve-3d;
                perspective: 800px;
                margin-top: 60px;
            }
            .card-3d-wrapper {
                width: 100%;
                height: 100%;
                position:absolute;
                top: 0;
                left: 0;
                -webkit-transform-style: preserve-3d;
                transform-style: preserve-3d;
                transition: all 600ms ease-out;
            }
            .card-front, .card-back {
                width: 100%;
                height: 100%;
                background-color: var(--bg-color);
                background-image: url('https://s3-us-west-2.amazonaws.com/s.cdpn.io/1462889/pat.svg');
                background-position: bottom center;
                background-repeat: no-repeat;
                background-size: 300%;
                position: absolute;
                border-radius: 12px;
                left: 0;
                top: 0;
                -webkit-transform-style: preserve-3d;
                transform-style: preserve-3d;
                -webkit-backface-visibility: hidden;
                -moz-backface-visibility: hidden;
                -o-backface-visibility: hidden;
                backface-visibility: hidden;
            }
            .card-back {
                transform: rotateY(180deg);
            }
            .checkbox:checked ~ .card-3d-wrap .card-3d-wrapper {
                transform: rotateY(180deg);
            }
            .center-wrap {
                position: absolute;
                width: 100%;
                padding: 0 35px;
                top: 50%;
                left: 0;
                transform: translate3d(0, -50%, 35px) perspective(100px);
                z-index: 20;
                display: block;
            }

            .form-group {
                position: relative;
                display: block;
                margin: 0;
                padding: 0;
            }
            .form-style {
                padding: 13px 20px;
                padding-left: 55px;
                height: 48px;
                width: 100%;
                font-weight: 500;
                border-radius: 4px;
                font-size: 14px;
                line-height: 22px;
                letter-spacing: 0.5px;
                outline: none;
                color: var(--text-color);
                background-color: var(--input-bg-color);
                border: none;
                -webkit-transition: all 200ms linear;
                transition: all 200ms linear;
                box-shadow: 0 4px 8px 0 rgba(21,21,21,.2);
            }
            .form-style:focus,
            .form-style:active {
                border: none;
                outline: none;
                box-shadow: 0 4px 8px 0 rgba(21,21,21,.2);
            }
            .input-icon {
                position: absolute;
                top: 0;
                left: 18px;
                height: 48px;
                font-size: 20px;
                line-height: 48px;
                text-align: left;
                color: var(--input-icon-color);
                -webkit-transition: all 200ms linear;
                transition: all 200ms linear;
            }

            .form-group input:-ms-input-placeholder {
                color: var(--text-color);
                opacity: 0.7;
                -webkit-transition: all 200ms linear;
                transition: all 200ms linear;
            }
            .form-group input::-moz-placeholder {
                color: var(--text-color);
                opacity: 0.7;
                -webkit-transition: all 200ms linear;
                transition: all 200ms linear;
            }
            .form-group input:-moz-placeholder {
                color: var(--text-color);
                opacity: 0.7;
                -webkit-transition: all 200ms linear;
                transition: all 200ms linear;
            }
            .form-group input::-webkit-input-placeholder {
                color: var(--text-color);
                opacity: 0.7;
                -webkit-transition: all 200ms linear;
                transition: all 200ms linear;
            }
            .form-group input:focus:-ms-input-placeholder {
                opacity: 0;
                -webkit-transition: all 200ms linear;
                transition: all 200ms linear;
            }
            .form-group input:focus::-moz-placeholder {
                opacity: 0;
                -webkit-transition: all 200ms linear;
                transition: all 200ms linear;
            }
            .form-group input:focus:-moz-placeholder {
                opacity: 0;
                -webkit-transition: all 200ms linear;
                transition: all 200ms linear;
            }
            .form-group input:focus::-webkit-input-placeholder {
                opacity: 0;
                -webkit-transition: all 200ms linear;
                transition: all 200ms linear;
            }

            .btn {
                border-radius: 4px;
                height: 44px;
                font-size: 13px;
                font-weight: 600;
                text-transform: uppercase;
                -webkit-transition: all 200ms linear;
                transition: all 200ms linear;
                padding: 0 30px;
                letter-spacing: 1px;
                display: -webkit-inline-flex;
                display: -moz-inline-flex;
                display: -ms-inline-flex;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                background-color: #FDB46C;
                color: var(--btn-text-color);
                box-shadow: 0 8px 24px 0 rgba(255,235,167,.2);
                border: none;
            }
            .btn:hover {
                background-color: var(--btn-hover-bg-color);
                color: var(--btn-hover-text-color);
            }

            .logo {
                position: absolute;
                top: 30px;
                right: 30px;
                display: block;
                z-index: 100;
                transition: all 250ms linear;
            }
            .logo img {
                height: 26px;
                width: auto;
                display: block;
            }

            .logo img.dark-mode {
                filter: invert(1);
            }

            .dark-mode {
                --bg-color: #ffffff;
                --text-color: black;
                --input-bg-color: #eeeeee;
                --input-icon-color: black;
                --btn-bg-color: black;
                --btn-text-color: white;
                --btn-hover-bg-color: black;
                --btn-hover-text-color: white;
            }

            @keyframes shake {
                0% {
                    transform: translateX(0);
                }
                25% {
                    transform: translateX(-20px);
                }
                50% {
                    transform: translateX(20px);
                }
                75% {
                    transform: translateX(-20px);
                }
                100% {
                    transform: translateX(0);
                }
            }

            .shake {
                animation: shake 0.40s;
                color: red;
                margin-top: 20px;
                font-size: 20px

            }
        </style>
    </head>
    <body>
        <div class="section full-height">
            <div class="container-fluid">
                <div class="row full-height justify-content-center">
                    <div class="col-12 text-center align-self-center py-5">
                        <div class="section pb-5 pt-5 pt-sm-2 text-center">
                            <div class="card-3d-wrap mx-auto">
                                <div class="card-3d-wrapper">
                                    <div class="card-front">
                                        <div class="center-wrap">
                                            <div class="section text-center">
                                                <h4 class="mb-4 pb-3">Log In</h4>
                                                <form action="AuthClient.jsp" data-sb-form-api-token="API_TOKEN" method="post" novalidate>
                                                    <div class="form-group">
                                                        <input type="text" name="username" class="form-style" placeholder="Username" id="username" autocomplete="off">
                                                        <i class="input-icon fas fa-user"></i> <!-- Add this line for the username icon -->
                                                    </div>	
                                                    <div class="form-group mt-2">
                                                        <input type="password" name="password" class="form-style" placeholder="Password" id="password" autocomplete="off">
                                                        <i class="input-icon fas fa-lock"></i> <!-- Add this line for the password icon -->
                                                    </div>
                                                    <button class="btn mt-4" type="submit">submit</button>
                                                    <%
                                                        String error = request.getParameter("error");
                                                        if ("true".equals(error)) {
                                                    %>
                                                    <div id="error-message" class="shake" style="color: red; margin-top: 20px;">Wrong Username & Password</div>
                                                    <%
                                                        }
                                                    %>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>  
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
