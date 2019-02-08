<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminPages.aspx.cs" Inherits="AdminPages" MasterPageFile="~/MasterPage.master" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <header class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-12 o-page__col-lg-12">
        <h1>Administrer sider</h1>
    </header>
    <asp:Panel ID="createPage" Visible="true" runat="server">
        <div class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-8 o-page__col-lg-8">
            <h2>Opret side</h2>
            <div class="form-group">
                <p class="u-margin-top-1 text-danger">
                    <asp:Label ID="lblError" Text="" runat="server" />
                </p>
                <label for="txtCreateName" class="control-label">Titel</label>
                <asp:TextBox ID="txtCreateName" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCreateName" ErrorMessage="Titel er påkrævet" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label for="txtCreateContent" class="col-sm-2 control-label">Indhold</label>
                <asp:TextBox ID="txtCreateContent" TextMode="MultiLine" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCreateContent" ErrorMessage="Indhold er påkrævet" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label for="fuImage" class="control-label">Evt. billede</label>
                <asp:FileUpload ID="fuImage" runat="server" />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Vælg en gyldig filtype (jpg, png eller gif)" ControlToValidate="fuImage" ForeColor="Red" ValidationExpression="^.*\.(jpg|JPG|png|PNG|gif|GIF)$"></asp:RegularExpressionValidator>
            </div>
            <div class="form-group">
                <asp:Button ID="btnCreatePage" CssClass="btn btn-default" runat="server" Text="Opret side" OnClick="btnCreatePage_Click" />
            </div>
        </div>
    </asp:Panel>
    <asp:Panel ID="editPage" Visible="false" runat="server">
        <div class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-12 o-page__col-lg-12">
            <h2>Rediger side</h2>
            <div class="form-group">
                <label for="txtName" class="control-label">Titel</label>
                <asp:TextBox ID="txtName" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtName" ErrorMessage="Titel er påkrævet." ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label for="txtContent" class="control-label">Indhold</label>
                <asp:TextBox ID="txtContent" TextMode="MultiLine" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtContent" ErrorMessage="Indhold er påkrævet" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <asp:Button ID="btnSavePage" CssClass="btn btn-default" runat="server" Text="Gem side" OnClick="btnSavePage_Click" />
            </div>
        </div>
    </asp:Panel>
    <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-12 o-page__col-lg-12">
        <h2>Oversigt over sider</h2>
        <div class="table-responsive">
            <asp:ListView ID="lvPages" runat="server">
                <LayoutTemplate>
                    <table class="table">
                        <tr>
                            <th>ID</th>
                            <th>Titel</th>
                            <th>Dato</th>
                            <th>Oprettet af</th>
                            <th></th>
                        </tr>
                        <tr runat="server" id="itemPlaceholder" />
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("PageID") %></td>
                        <td><a href='/service/<%# Eval("URL") %>.aspx'><%# Eval("PageName") %></a></td>
                        <td><%# Eval("DateCreated") %></td>
                        <td><%# Eval("Name") %></td>
                        <td>
                            <a class="btn btn-default" href='?edit=<%# Eval("PageID") %>'>Rediger side</a>
                            <asp:Button runat="server" class="btn btn-danger" Text="Slet side" OnClientClick="if(!confirm('Er du sikker på, at du vil slette denne side?')) return false;" CommandArgument='<%# Eval("PageID") %>' OnClick="deletePage" />
                        </td>
                    </tr>
                </ItemTemplate>
                <EmptyDataTemplate>
                    <p class="u-margin-bottom-2">Der er ingen sider på nuværende tidspunkt.</p>
                </EmptyDataTemplate>
            </asp:ListView>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="Server">
    <script src="https://cloud.tinymce.com/stable/tinymce.min.js"></script>
    <script>tinymce.init({
    selector: 'textarea'
});</script>
</asp:Content>
