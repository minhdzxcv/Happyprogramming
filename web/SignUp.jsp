<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Student Registration Form</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.css">
        <style>
            .card-registration .select-input.form-control[readonly] {
                background-color: #fbfbfb;
                border: 1px solid #ced4da;
                border-radius: 4px;
                padding-left: .75rem;
                padding-right: .75rem;
            }
            .card-registration .select-arrow {
                top: 13px;
            }
        </style>
    </head>
    <body>
        <section class="h-100 bg-dark">
            <div class="container py-5 h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col">
                        <div class="card card-registration my-4">
                            <div class="row g-0">
                                <div class="col-xl-6 d-none d-xl-block">
                                    <img src="img/image.jpg"
                                         alt="Sample photo" class="img-fluid"
                                         style="border-top-left-radius: .25rem; border-bottom-left-radius: .25rem;" />
                                </div>
                                <div class="col-xl-6">
                                    <div class="card-body p-md-5 text-black">
                                        <h3 class="mb-5 text-uppercase">Student Registration Form</h3>
                                        <form action="signup" method="post">
                                            <div class="row">
                                                <div class="col-md-6 mb-4">
                                                    <div class="form-outline">
                                                        <input type="text" name="username" id="username" class="form-control form-control-lg" required />
                                                        <label class="form-label" for="username" >User Name</label>
                                                    </div>
                                                </div>
                                                <div class="col-md-6 mb-4">
                                                    <div class="form-outline">
                                                        <input type="text" id="fullname" name="fullname" class="form-control form-control-lg" required />
                                                        <label class="form-label" for="fullname">Full Name</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">


                                                <div class="col-md-6 mb-4">
                                                    <div class="form-outline">
                                                        <input type="password" id="password" name="password" class="form-control form-control-lg" required />
                                                        <label class="form-label" for="password">Password</label>
                                                    </div>
                                                </div>

                                                <div class="col-md-6 mb-4">
                                                    <div class="form-outline">
                                                        <input type="password" id="confirmpassword" name="repass" class="form-control form-control-lg" required />
                                                        <label class="form-label" for="confirmpassword">Confirm Password</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-outline mb-4">
                                                <input type="text" id="address" name="address" class="form-control form-control-lg" required />
                                                <label class="form-label" for="address">Address</label>
                                            </div>
                                            <div class="form-outline mb-4">
                                                <input type="text" id="phone" name="phone" class="form-control form-control-lg" required />
                                                <label class="form-label" for="phone">Phone</label>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6 mb-4">
                                                    <select class="form-select" id="gender" name="gender" required>
                                                        <option selected disabled value="">Gender</option>
                                                        <option value="female">Female</option>
                                                        <option value="male">Male</option>

                                                    </select>
                                                </div>
                                                <div class="col-md-6 mb-4">
                                                    <select class="form-select" id="role" name="role" required>
                                                        <option selected disabled value="">Role</option>
                                                        <option value="mentor">Mentor</option>
                                                        <option value="mentee">Mentee</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-outline mb-4">
                                                <input type="date" id="dob" name="dob" class="form-control form-control-lg" required />
                                                <label class="form-label" for="dob">Date of Birth</label>
                                            </div>
                                            <div class="form-outline mb-4">
                                                <input type="email" id="email" name="email" class="form-control form-control-lg" required />
                                                <label class="form-label" for="email">Email</label>
                                            </div>
                                            <label style="color:red">${alert}</label></br>
                                            <div class="d-flex justify-content-end pt-3">
                                                <button type="reset" class="btn btn-light btn-lg">Reset all</button>

                                                <button type="submit" class="btn btn-warning btn-lg ms-2">Submit form</button>


                                                <button type="button" class="btn btn-primary btn-lg ms-2" onclick="window.location.href = 'signin'">Sign In</button>
                                            </div>
                                        </form>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.js"></script>
    </body>
</html>
