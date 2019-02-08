<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminUsers.aspx.cs" Inherits="AdminUsers" MasterPageFile="~/MasterPage.master" enableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-12 o-page__col-lg-12">
        <h1>Administrer brugere</h1>
        <div class="table-responsive">
            <asp:listview id="lvUsers" runat="server">
                <LayoutTemplate>
                    <table class="table">
                        <tr>
                            <th>ID</th>
                            <th>Navn</th>
                            <th>Adresse</th>
                            <th>Postnummer</th>
                            <th>By</th>
                            <th>Telefon</th>
                            <th>E-mail</th>
                            <th>Oprettet</th>
                            <th>Brugertype</th>
                            <th></th>
                        </tr>
                        <tr runat="server" id="itemPlaceholder" />
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                        <asp:Label ID="UserID" runat="server" Text='<%# Eval("UserID") %>' />
                        </td>
                        <td><input type="text" class="form-control" name='<%# "Name" + Eval("UserID") %>' Value='<%# Eval("Name") %>' /></td>
                        <td><input type="text" class="form-control" name='<%# "Address" + Eval("UserID") %>' Value='<%# Eval("Address") %>' /></td>
                        <td><input type="text" class="form-control" name='<%# "Zip" + Eval("UserID") %>' Value='<%# Eval("Zip") %>' /></td>
                        <td><input type="text" class="form-control" name='<%# "City" + Eval("UserID") %>' Value='<%# Eval("City") %>' /></td>
                        <td><input type="text" class="form-control" name='<%# "Telephone" + Eval("UserID") %>' Value='<%# Eval("Telephone") %>' /></td>
                        <td><input type="text" class="form-control" name='<%# "Email" + Eval("UserID") %>' Value='<%# Eval("Email") %>' /></td>
                        <td><%# Eval("DateSignedUp") %></td>
                        <td><input type="number" min="1" max="3" class="form-control" name='<%# "FK_UserLevelID" + Eval("UserID") %>' Value='<%# Eval("FK_UserLevelID") %>' /> <%# Eval("UserLevelName") %>
                        <td>
                        <asp:Button runat="server" class="btn btn-default" Text="Opdatér bruger" CommandArgument='<%# Eval("UserID") %>' OnClick="editUser"/>
                        <asp:Button runat="server" class="btn btn-danger" Text="Slet bruger" OnClientClick="if(!confirm('Er du sikker på, at du vil slette denne bruger?')) return false;" CommandArgument='<%# Eval("UserID") %>' OnClick="deleteUser" />
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:listview>
        </div>
    </section>
</asp:Content>
