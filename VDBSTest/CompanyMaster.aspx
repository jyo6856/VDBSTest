<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CompanyMaster.aspx.cs" Inherits="VDBSTest.CompanyMaster" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="Label1" Text="Name" Font-Bold="true" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server"></asp:TextBox> 
                    </td>
                </tr>
                <tr><td></td><td><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtName" ForeColor="Red" ErrorMessage="Enter Name."></asp:RequiredFieldValidator></td></tr>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="Label2" Text="Upload Files" Font-Bold="true" />
                    </td>
                    <td>
                        <asp:FileUpload ID="FileUpload1" runat="server" AllowMultiple="true" />
                    </td>
                </tr>
                <tr><td></td><td><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="FileUpload1" ForeColor="Red" ErrorMessage="Choose a file."></asp:RequiredFieldValidator></td></tr>
                <tr>
                    <td colspan="2">
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                    </td>  
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
