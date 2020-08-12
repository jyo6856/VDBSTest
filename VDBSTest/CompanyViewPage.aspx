<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CompanyViewPage.aspx.cs" Inherits="VDBSTest.CompanyViewPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src='https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.3.min.js'></script>
<script type="text/javascript" src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/js/bootstrap.min.js'></script>
<link rel="stylesheet" href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/css/bootstrap.min.css'
    media="screen" />
    <script type="text/javascript">
    function ShowPopup(title) {
        $("#MyPopup .modal-title").html(title); 
        $("#MyPopup").modal("show");
        }
        function ShowPopup1(title) {
        $("#MyPopup1 .modal-title").html(title); 
        $("#MyPopup1").modal("show");
    }
</script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <div style="padding-left:20px"><br />
            <asp:Label ID="Label1" runat="server" Text="Uploaded Files." Font-Bold="true" ></asp:Label><br />
            <asp:Label ID="lblMsg" runat="server" Text="" ForeColor="Green"></asp:Label>
            <br />
            <asp:UpdatePanel ID="gridContainer" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:GridView ID="gridFile" runat="server" AutoGenerateColumns="false" DataKeyNames="Id" OnRowCommand="gridFile_RowCommand">
                        <EmptyDataTemplate>
                            You have not uploaded any files.
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:TemplateField HeaderText="ID" ItemStyle-Width="50px" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblstatus" runat="server" Text='<%#Eval("Status")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ID" ItemStyle-Width="50px">
                                <ItemTemplate>
                                    <asp:Label ID="lblId" runat="server" Text='<%#Eval("Id")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="File Name" ItemStyle-Width="200px">
                                <ItemTemplate>
                                    <asp:Label ID="lblFileName" runat="server" Text='<%#Eval("Name")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action" ItemStyle-Width="250px" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Button ID="btnShow" runat="server" CommandName="Show" CausesValidation="false" Text="Show" CommandArgument='<%# Eval("Id") %>' />
                                    <asp:Button ID="btnApproveDisapprove" runat="server" CommandName="ApproveDisapprove" CausesValidation="false" Text="Approve/Disapprove" CommandArgument='<%# Eval("Id") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel> 

            <div id="MyPopup" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">
                                &times;</button>
                            <h4 class="modal-title"></h4>
                        </div>
                        <div class="modal-body">
                            <iframe src="DownloadFiles.aspx" id="iframdipfiles" width="500px" height="400px"></iframe>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

            <div id="MyPopup1" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">
                                &times;</button>
                            <h4 class="modal-title"></h4>
                        </div>
                        <div class="modal-body">
                            <table>
                                <tr>
                                    <th colspan="2">
                                        Approve/ Disapprove Files.
                                    </th> 
                                </tr>
                                <tr>
                                    <td colspan="2"></td> 
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Button ID="btnAppr" runat="server" Text="Approve" OnClick="btnAppr_Click" />
                                    </td>
                                    <td>
                                        <asp:Button ID="btnDisAppr" runat="server" Text="Disapprove" OnClick="btnDisAppr_Click" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
