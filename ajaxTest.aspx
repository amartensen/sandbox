<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ajaxTest.aspx.cs" Inherits="ajaxTest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.templates/beta1/jquery.tmpl.js"></script>
    

</head>
<body>
    
    <script type="text/javascript">
       
        $(document).ready(function () {
            // Add the page method call as an onload handler for the window.
            $(window).load(function () {
                $.ajax({
                    type: "POST",
                    url: "ajaxTest.aspx/getTeamMembers",
                    data: "{}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: Success
                });
            });
        
            function Success(data, status) {
                //alert(data.d);
                $("#peopleTemp").tmpl(data.d).appendTo("#peopleContainer");
            }
            
            $("#testBu").click(function () {
                $.ajax({
                    type: "POST",
                    url: "ajaxTest.aspx/GetPerson",
                    data: "{'id':'" + $("#Text1").val()+"'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        //alert(data.d);
                        $("#personTemp").tmpl(data.d).appendTo("#personDetail");
                    }
                });
            });

            $("#Submit1").click(function () {
                $.ajax({
                    type: "POST",
                    url: "ajaxTest.aspx/newTeamMembers",
                    data: "{'fName': '" + $('#fNameTB').val() + "', 'lName': '" + $('#lNameTB').val() + "', 'teamID': '" + $('#teamIDTB').val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        //alert(data.d);
                        $("#alertBox").html("added!")
                        getTeamMembers();
                    }
                });
            });
            
        });
    </script>

    <!-- jTemplates -->
    //people template
    <script id="peopleTemp" type="text/x-jquery-tmpl">
        <tr>
            <td><span class="perSelect">${fName}</span></td>
            <td>${lName}</td>
            <td>${tmMemberID}</td>
            <td>${teamID}</td>
            <td>${grade}</td>
            <td>${userID}</td>
        </tr>
    </script>

    //person temp
    <script id="personTemp" type="text/x-jquery-tmpl">
        
            Name: ${fname} ${lname} <br />
            ID: ${id}
        
    </script>


    <form id="form1" runat="server"></form>
    <div>
        <input id="testBu" type="button" value="Test" />
        <input id="Text1" type="text" />
    </div>
    
    <table>
        <thead>
            <tr>
                <th>First Name</th><th>Last Name</th><th>Age</th>
            </tr>
        </thead>
        <tbody id="peopleContainer">
        </tbody>
    </table>
    
    <div id="personDetail">

    </div>

    <div id="newPerson">
        <h1>create a new person!</h1>
        <form>
            <label for="fNameTB">First Name:</label><br />
            <input id="fNameTB" type="text" /><br />
            <label for="lNameTB">Last Name:</label><br />
            <input id="lNameTB" type="text" /><br />
            <label for="teamIDTB">TeamID:</label><br />
            <input id="teamIDTB" type="text" /><br />

            <input id="Submit1" type="button" value="submit" />
        </form>
        <div id="alertBox"></div>
    </div>
    
    
</body>
</html>
