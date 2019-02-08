<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminCategories.aspx.cs" Inherits="AdminCategories" MasterPageFile="~/MasterPage.master" enableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-12 o-page__col-lg-12">
        <h1>Administrer kategorier</h1>
        <h2>Opret ny</h2>
        <div class="form-group">
            <label for="txtCategoryName" class="control-label">Titel</label>
            <asp:TextBox ID="txtCategoryName" CssClass="form-control" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCategoryName" ErrorMessage="Titel er påkrævet." ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
             <label for="fuImage" class="control-label">Evt. baggrundsbillede</label>
             <asp:FileUpload ID="fuImage" runat="server" />
        </div>
        <div class="form-group">
            <asp:Button ID="btnNewCategory" CssClass="btn btn-default" runat="server" Text="Opret kategori" OnClick="btnNewCategory_Click" />
        </div>
        <h2>Oversigt over kategorier</h2>
        <div class="table-responsive">
            <asp:listview id="lvCategories" runat="server">
                <LayoutTemplate>
                    <table class="table">
                        <tr>
                            <th>ID</th>
                            <th>Navn</th>
                            <th></th>
                        </tr>
                        <tr runat="server" id="itemPlaceholder" />
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                        <asp:Label ID="UserID" runat="server" Text='<%# Eval("CategoryID") %>' />
                        </td>
                        <td><input type="text" class="form-control" name='<%# "Name" + Eval("CategoryID") %>' Value='<%# Eval("CategoryName") %>' /></td>
                        <td>
                            <asp:Button runat="server" class="btn btn-default" Text="Opdatér kategori" CommandArgument='<%# Eval("CategoryID") %>' OnClick="editCategory"/>
                            <asp:Button runat="server" class="btn btn-danger" Text="Slet kategori" OnClientClick="if(!confirm('Er du sikker på, at du vil slette denne kategori? OBS! Vær opmærksom på, at du også sletter nyhederne under kategorien')) return false;" CommandArgument='<%# Eval("CategoryID") %>' OnClick="deleteCategory" />
                        </td>
                    </tr>
                </ItemTemplate>
                <EmptyDataTemplate>
                    <p class="u-margin-bottom-2">Der er ingen kategorier på nuværende tidspunkt.</p>
                </EmptyDataTemplate>
            </asp:listview>
        </div>
    </section>
</asp:Content>
