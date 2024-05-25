<%-- 
    Document   : recoveryCodeAdmin
    Created on : May 15, 2024, 8:36:04 PM
    Author     : ADMIN
--%>

<%-- 
    Document   : forgotPassword
    Created on : May 14, 2024, 11:02:55 AM
    Author     : ADMIN
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<!------ Include the above in your HEAD tag ---------->
<style>
    .form-gap {
        padding-top: 70px;
    }
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<div class="form-gap"></div>
<div class="container">
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="text-center">
                        <h3><i class="fa fa-lock fa-4x"></i></h3>
                        <h2 class="text-center">SignIn Admin?</h2>
                        <p>You need to enter your name and email to get to the administrator signin page</p>
                        
                        <p style="color: red"> ${message} </p>
                        <div class="panel-body">
                            <form id="register-form" action="recovery" role="form" autocomplete="off" class="form" method="post">
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-user color-blue"></i></span>
                                        <input id="name" name="name" placeholder="Enter your name" class="form-control" type="text" required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-envelope color-blue"></i></span>
                                        <input id="email" name="email" placeholder="Email address" class="form-control" type="email" required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <input name="recover-submit" class="btn btn-lg btn-primary btn-block" value="Submit" type="submit">
                                </div>
                                <input type="hidden" class="hide" name="token" id="token" value="">
                                <div class="form-group">
                                    <a href="signin" class="btn btn-link">Back to Sign In</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
