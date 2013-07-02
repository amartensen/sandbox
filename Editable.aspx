<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Editable.aspx.cs" Inherits="Editable" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script src="Scripts/jquery.jeditable.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <p id="test" class="editable">Try me!!</p>
        
    </div>
    <div id="div2"></div>
    </form>

    <script type="text/javascript">
        $(document).ready(function () {
            var div = $('#div2')
            $('.editable').editable(function (value, settings) {
                console.log(this);
                div.append(value);
                return (value);
            }, {
                type: 'textarea',
                submit: 'OK',
            });
            });
    </script>
</body>
</html>
