<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DownloadFiles.aspx.cs" Inherits="VDBSTest.DownloadFiles" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="gridDownloadFile" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="File Name" ItemStyle-Width="200px" >
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkDownload" runat="server" Text='<%# Eval("Name") %>' OnClick="DownloadFile"
                                CommandArgument='<%# Eval("Id") %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
