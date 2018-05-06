<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainForm.aspx.cs" Inherits="ArtistsWebBilling.MainForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ArtistsWebBilling</title>
</head>
<body>
    <form id="mainform" runat="server">
    <div>
    
        <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Size="X-Large" ForeColor="#6600CC" Text="Welcome to web billing system for artists commissions" Width="561px"></asp:Label>
        <br />
        <br />
    
        <asp:Label ID="Label1" runat="server" Text="Period:"></asp:Label>
        <br />
        <asp:TextBox ID="tbFirstDate" runat="server" TextMode="Date" Width="154px"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="tbLastDate" runat="server" TextMode="Date" width="154px"></asp:TextBox>
        <br />
        <asp:Label ID="Label3" runat="server" Text="Artist:"></asp:Label>
        <br />
        <asp:DropDownList ID="ddlArtist" runat="server" Height="20px" Width="350px" DataSourceID="dsArtist" DataTextField="Name" DataValueField="ID">
        </asp:DropDownList>
        <br />
        <br />
        <asp:Button ID="bShowComission" runat="server" OnClick="bShowComission_Click" Text="Artist commission" width="158px" />
    
    
        
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="bShowSnapshot" runat="server" OnClick="bShowSnapshot_Click" Text="Tracks snapshot" width="158px" />
    
    
        
        <asp:SqlDataSource ID="dsArtist" runat="server" ConnectionString="<%$ ConnectionStrings:RVLDBConnection %>" SelectCommand="SELECT * FROM [Artist] ORDER BY [Name]"></asp:SqlDataSource>
    
    
        
        <p>
            <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Size="X-Large" ForeColor="#6600CC" Text="Maintenance" Width="149px"></asp:Label>
        </p>
       
            <asp:Label ID="Label6" runat="server" Text="Desired artists count:"></asp:Label>
        <br />
            <asp:TextBox ID="tbArtistCount" runat="server" TextMode="Number"></asp:TextBox>
            <br />
        <br />
            <asp:Button ID="bReloadData" runat="server" OnClick="bReloadData_Click" Text="Regenerate data" UseSubmitBehavior="False" />
        <br />
        <br />
            <asp:ListBox ID="lbStatus" runat="server" Height="144px" Width="709px"></asp:ListBox>
        
        </div>
    </form>
</body>
</html>
