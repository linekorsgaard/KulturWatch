<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminCreateNews.aspx.cs" Inherits="AdminCreateNews" MasterPageFile="~/MasterPage.master" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-12 o-page__col-lg-12">
        <h1>Opret nyhed</h1>
        <div class="form-group">
            <p class="u-margin-top-1 text-danger">
                <asp:Label ID="lblError" Text="" runat="server" />
            </p>
            <label for="txtHeadline" class="control-label">Rubrik</label>
            <asp:TextBox ID="txtHeadline" CssClass="form-control" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtHeadline" ErrorMessage="Rubrik er påkrævet" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <label for="txtLede" class="col-sm-2 control-label">Manchet</label>
            <asp:TextBox ID="txtLede" CssClass="form-control" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtLede" ErrorMessage="Manchet er påkrævet." ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <label for="txtBodyText" class="col-sm-2 control-label">Indhold</label>
            <asp:TextBox ID="txtBodyText" TextMode="MultiLine" CssClass="form-control" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtBodyText" ErrorMessage="Indhold er påkrævet." ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
        <asp:FileUpload ID="fuImage" runat="server" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Billede er påkrævet." ControlToValidate="fuImage" ForeColor="Red"></asp:RequiredFieldValidator><br />
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Vælg en gyldig filtype (jpg, png eller gif)" ControlToValidate="fuImage" ForeColor="Red" ValidationExpression="^.*\.(jpg|JPG|png|PNG|gif|GIF)$"></asp:RegularExpressionValidator>
        <div class="form-group">
            <div class="checkbox">
                <label>
                    <asp:CheckBox ID="chkLocked" runat="server" />
                    Låst artikel
                </label>
            </div>
        </div>
        <div class="form-group">
            <label for="ddlCategory" class="control-label"></label>
            <asp:DropDownList ID="ddlCategory" runat="server"></asp:DropDownList>
        </div>
        <div class="form-group">
            <asp:Button ID="btnCreateNews" CssClass="btn btn-default" runat="server" Text="Opret nyhed" OnClick="btnCreateNews_Click" />
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="Server">
    <script src="https://cloud.tinymce.com/stable/tinymce.min.js"></script>
    <script>tinymce.init({ selector: 'textarea' });</script>
</asp:Content>
