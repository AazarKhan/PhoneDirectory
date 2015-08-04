<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainPage.aspx.cs" Inherits="Phone_Directory.MainPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/font-awesome.min.css" rel="stylesheet" />
    <link href="http://fonts.googleapis.com/css?family=Goudy+Bookletter+1911" rel="stylesheet" type="text/css" />
    <link href="http://fonts.googleapis.com/css?family=Raleway:100" rel="stylesheet" type="text/css" />
    <link href="css/own-stylesheet.css" rel="stylesheet" />

    <script src="javascript/jquery-1.11.3.min.js"></script>
    <script src="javascript/bootstrap.min.js"></script>
    <script src="javascript/jquery.blockUI.js"></script>

<%--    <script src="http://malsup.github.io/jquery.blockUI.js"></script>--%>

    <title>Main Page | Phone Directory</title>

</head>
<body>
    <form id="form1" runat="server">

        <div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
                        <h3 class="modal-title" id="lineModalLabel">Add New Directory</h3>
                    </div>
                    <div class="modal-body">

                        <!-- content goes here -->

                        <div class="form-group">
                            <asp:TextBox runat="server" ID="TextBoxNumber" CssClass="form-control my-form" placeholder="Number"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:TextBox runat="server" ID="TextBoxName" CssClass="form-control my-form" placeholder="Name"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:TextBox runat="server" ID="TextBoxCity" CssClass="form-control my-form" placeholder="City"></asp:TextBox>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <div class="btn-group btn-group-justified" role="group" aria-label="group button">
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-default" data-dismiss="modal" role="button" onclick="removeText()">Close</button>
                            </div>
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-default btn-hover-green" runat="server" onserverclick="Add_Click">Save</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="container maindiv">

            <div style="overflow: hidden; text-align: center;">
                <h1>Phone Directory</h1>
            </div>

            <div style="position: absolute; margin-left: 480px; margin-top: 20px; width: 400px;">

                <div class="input-group">
                    <span class="input-group-btn" data-toggle="modal" data-target="#basicModal">
                        <button class="btn btn-default" data-toggle="tooltip" data-placement="top" type="button" title="Add"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></button>
                    </span>

                    <asp:TextBox ID="SearchBox" runat="server"  CssClass="form-control" placeholder="Search by Number, Name or City.."></asp:TextBox>

                    <span class="input-group-btn">
                        <button class="btn btn-default myButton" runat="server" onserverclick="SearchButton_Click" type="button" data-toggle="tooltip" data-placement="top" title="Search Keyword">
                            <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                        </button>
                    </span>

                    <span class="input-group-btn">
                        <button class="btn btn-default myButton" runat="server" onserverclick="ShowData_Click" type="button" data-toggle="tooltip" data-placement="top" title="List All">
                            <span class="glyphicon glyphicon-list" aria-hidden="true"></span>
                        </button>
                    </span>
                </div>

                <b><asp:Label ID="LabelGrid" runat="server" Text=""></asp:Label></b>
            </div>


            <div id="blockMe" style="margin-top: 85px;">
                <asp:GridView CssClass="table table-bordered table-hover text-center" ID="DataGrid" runat="server">
                </asp:GridView>
            </div>
        </div>
    </form>

    <script type="text/javascript">

        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip(); // initialize tooltip

            $('.myButton').click(function () {
                $('#blockMe').block({
                    message: '<h4> <asp:Image runat="server" Width="25" Height="25" ImageUrl="~/Images/ajax-loader.gif" />Loading results.. <h4>',
                    css: {
                        border: 'none',
                        padding: '5px',
                        backgroundColor: '#000',
                        '-webkit-border-radius': '10px',
                        '-moz-border-radius': '10px',
                        opacity: .6,
                        color: '#DEE2E8'
                    }
                });
            });
        });
        
        function removeText() {
            $('#TextBoxNumber').val("");
            $('#TextBoxName').val("");
            $('#TextBoxCity').val("");
        }
    </script>

</body>
</html>
