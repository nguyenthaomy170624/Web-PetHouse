<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GetCartCount.aspx.cs" Inherits="Web_PetHouse.NguoiDung.GetCartCount" %>
<% 
    Response.Clear();
    Response.ContentType = "text/plain";
    Response.Write(Session["cartCount"] != null ? Session["cartCount"].ToString() : "0");
    Response.End();
%>
