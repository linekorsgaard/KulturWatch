<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Events.aspx.cs" Inherits="Events" MasterPageFile="~/MasterPage.master" EnableEventValidation="false" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <ol class="breadcrumb u-margin-left-1">
        <li><a href="/">KulturWatch</a></li>
        <li class="active">Mine begivenheder</li>
    </ol>
    <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-12 o-page__col-lg-12">
        <h1>Mine begivenheder</h1>
        <a href="#ovEvents">Gå til oversigt over dine begivenheder</a>
        <h2>Opret ny</h2>
        <div class="form-group">
            <label for="txtEventName" class="control-label">Titel</label>
            <asp:textbox id="txtEventName" cssclass="form-control" runat="server"></asp:textbox>
            <asp:requiredfieldvalidator id="RequiredFieldValidator1" runat="server" controltovalidate="txtEventName" errormessage="Titel er påkrævet" forecolor="Red"></asp:requiredfieldvalidator>
        </div>
        <div class="form-group">
            <label for="txtEventDescription" class="control-label">Beskrivelse</label>
            <asp:textbox id="txtEventDescription" textmode="MultiLine" cssclass="form-control" runat="server"></asp:textbox>
            <asp:requiredfieldvalidator id="RequiredFieldValidator2" runat="server" controltovalidate="txtEventDescription" errormessage="Beskrivelse er påkrævet" forecolor="Red"></asp:requiredfieldvalidator>
        </div>
        <div class="form-group">
            <label for="txtEventStart" class="control-label">Dato start</label>
            <asp:textbox id="txtEventStart" textmode="Date" cssclass="form-control" runat="server"></asp:textbox>
            <asp:requiredfieldvalidator id="RequiredFieldValidator3" runat="server" controltovalidate="txtEventStart" errormessage="Startdato er påkrævet" forecolor="Red"></asp:requiredfieldvalidator>
            <br />
            <asp:comparevalidator id="CompareValidator1" runat="server" controltovalidate="txtEventStart" errormessage="Dato skal være i dag eller i fremtiden." forecolor="Red" operator="GreaterThanEqual" type="Date"></asp:comparevalidator>
        </div>
        <div class="form-group">
            <label for="txtEventEnd" class="control-label">Dato slut</label>
            <asp:textbox id="txtEventEnd" textmode="Date" cssclass="form-control" runat="server"></asp:textbox>
            <asp:requiredfieldvalidator id="RequiredFieldValidator4" runat="server" controltovalidate="txtEventEnd" errormessage="Slutdato er påkrævet" forecolor="Red"></asp:requiredfieldvalidator>
            <br />
            <asp:comparevalidator id="CompareValidator2" runat="server" controltovalidate="txtEventEnd" errormessage="Dato skal være i dag eller i fremtiden." forecolor="Red" operator="GreaterThanEqual" type="Date"></asp:comparevalidator>
        </div>
        <div class="form-group">
            <label for="txtPrice" class="control-label">Normalpris for begivenheden (voksen)</label>
            <asp:textbox id="txtPrice" cssclass="form-control" runat="server"></asp:textbox>
            <asp:requiredfieldvalidator id="RequiredFieldValidator5" runat="server" controltovalidate="txtPrice" errormessage="Pris er påkrævet" forecolor="Red"></asp:requiredfieldvalidator>
        </div>
        <div class="form-group">
            <label for="txtReducedPrice" class="control-label">Reduceret pris for KulturWatch's medlemmer</label>
            <p>Lad feltet stå tomt, hvis ingen rabat</p>
            <asp:textbox id="txtReducedPrice" cssclass="form-control" runat="server"></asp:textbox>
        </div>
        <div class="form-group">
            <asp:button id="btnNewEvent" cssclass="btn btn-default" runat="server" text="Send begivenhed til godkendelse" onclick="btnNewEvent_Click" />
        </div>
        <h2 id="ovEvents" class="u-margin-top-2">Oversigt over dine begivenheder</h2>
        <div class="table-responsive">
            <asp:listview id="lvEvents" runat="server">
                <LayoutTemplate>
                    <table class="table u-margin-bottom-2">
                        <tr>
                            <th>Titel</th>
                            <th>Beskrivelse</th>
                            <th>Dato start</th>
                            <th>Dato slut</th>
                            <th>Pris</th>
                            <th>Reduceret pris</th>
                            <th>Status</th>
                        </tr>
                        <tr runat="server" id="itemPlaceholder" />
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("EventName") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lblDateStart" runat="server" Text='<%# Eval("DateStart") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lblDateEnd" runat="server" Text='<%# Eval("DateEnd") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Price") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lblReducedPrice" runat="server" Text='<%# Eval("ReducedPrice") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lblEventStatus" runat="server" Text='<%# Eval("Name") %>' />
                        </td>
                    </tr>
                </ItemTemplate>
                <EmptyDataTemplate>
                    <p class="u-margin-bottom-2">Du har ingen oprettede events endnu.</p>
                </EmptyDataTemplate>
            </asp:listview>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="Server">
    <script src="https://cloud.tinymce.com/stable/tinymce.min.js"></script>
    <script>tinymce.init({ selector: 'textarea' });</script>
</asp:Content>
