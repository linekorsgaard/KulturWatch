<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminNews.aspx.cs" Inherits="AdminNews" MasterPageFile="~/MasterPage.master" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-12 o-page__col-lg-12">
        <h1>Administrer nyheder</h1>
        <asp:Panel ID="editNews" Visible="false" runat="server">
            <h2>Rediger nyhed</h2>
            <div class="form-group">
                <label for="txtHeadline" class="control-label">Rubrik</label>
                <asp:TextBox ID="txtHeadline" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtHeadline" ErrorMessage="Rubrik er påkrævet" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label for="txtLede" class="col-sm-2 control-label">Manchet</label>
                <asp:TextBox ID="txtLede" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtLede" ErrorMessage="Manchet er påkrævet" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label for="txtBodyText" class="col-sm-2 control-label">Indhold</label>
                <asp:TextBox ID="txtBodyText" TextMode="MultiLine" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtBodyText" ErrorMessage="Indhold er påkrævet" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <div class="checkbox">
                    <label>
                        <asp:CheckBox ID="chkLocked" runat="server" />
                        Låst artikel
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="ddlCategory" class="col-sm-2 control-label"></label>
                <asp:DropDownList ID="ddlCategory" runat="server"></asp:DropDownList>
            </div>
            <div class="form-group">
                <asp:Button ID="btnSaveNews" CssClass="btn btn-default" runat="server" Text="Gem nyhed" OnClick="btnSaveNews_Click" />
            </div>
        </asp:Panel>
        <h2>Oversigt over nyheder</h2>
        <div class="table-responsive">
            <asp:ListView ID="lvNews" runat="server">
                <LayoutTemplate>
                    <table class="table">
                        <tr>
                            <th>ID</th>
                            <th>Overskrift</th>
                            <th>Dato</th>
                            <th>Skrevet af</th>
                            <th></th>
                        </tr>
                        <tr runat="server" id="itemPlaceholder" />
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("ArticleID") %></td>
                        <td><a href='/<%# Eval("CategoryURL") %>/<%# Eval("URL") %>.aspx'><%# Eval("Headline") %></a></td>
                        <td><%# Eval("DatePublished") %></td>
                        <td><%# Eval("Name") %></td>
                        <td>
                            <a class="btn btn-default" href='?edit=<%# Eval("ArticleID") %>'>Rediger nyhed</a>
                            <asp:Button ID="btnDeleteComment" runat="server" class="btn btn-danger" Text="Slet nyhed" OnClientClick="if(!confirm('Er du sikker på, at du vil slette denne nyhed?')) return false;" CommandArgument='<%# Eval("ArticleID") %>' OnClick="deleteNews" />
                        </td>
                    </tr>
                </ItemTemplate>
                <EmptyDataTemplate>
                    <p class="u-margin-bottom-2">Der er ingen nyheder på nuværende tidspunkt.</p>
                </EmptyDataTemplate>
            </asp:ListView>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="Server">
    <script src="https://cloud.tinymce.com/stable/tinymce.min.js"></script>
    <script>tinymce.init({ selector: 'textarea' });</script>
</asp:Content>
