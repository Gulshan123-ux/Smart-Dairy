<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.smartdairy.util.OtpUtil" %>

<%
    // Already logged-in user ko module page par bhejo.
    if (session.getAttribute("userId") != null) {
        response.sendRedirect(request.getContextPath() + "/modules.jsp");
        return;
    }

    String ctx = request.getContextPath();

    // OTP step tabhi dikhao jab OTP bheja ja chuka ho aur expire na hua ho.
    String otpMobile = (String) session.getAttribute("otpMobile");
    Long otpExpiry = (Long) session.getAttribute("otpExpiry");
    boolean otpStep = otpMobile != null && otpExpiry != null
                      && otpExpiry > System.currentTimeMillis();

    String devOtp = (String) session.getAttribute("devOtp");

    String error = request.getParameter("error");
    String message = "";

    if ("mobile".equals(error)) {
        message = "Please enter a valid 10 digit mobile number.";
    } else if ("empty".equals(error)) {
        message = "Please enter your mobile number.";
    } else if ("notfound".equals(error)) {
        message = "This mobile number is not registered.";
    } else if ("wait".equals(error)) {
        message = "Please wait 30 seconds before asking for a new OTP.";
    } else if ("wrong".equals(error)) {
        message = "Wrong OTP. Please try again.";
    } else if ("expired".equals(error)) {
        message = "OTP expired. Please request a new OTP.";
    } else if ("locked".equals(error)) {
        message = "Too many wrong attempts. Please request a new OTP.";
    } else if ("smsfail".equals(error)) {
        message = "Could not send OTP. Please try again later.";
    } else if ("server".equals(error)) {
        message = "Server error. Please try again.";
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Smart Dairy | Login</title>

<style>
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
        font-family: Arial, Helvetica, sans-serif;
    }

    body {
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
        background: linear-gradient(135deg, #e8f5e9, #c8e6c9);
    }

    .login-container {
        width: 100%;
        max-width: 420px;
        background: #ffffff;
        padding: 35px;
        border-radius: 18px;
        box-shadow: 0 12px 35px rgba(0, 0, 0, 0.13);
    }

    .logo {
        width: 72px;
        height: 72px;
        margin: 0 auto 15px;
        border-radius: 50%;
        background: #e8f5e9;
        color: #2e7d32;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 36px;
    }

    h1 {
        text-align: center;
        color: #2e7d32;
        font-size: 28px;
        margin-bottom: 8px;
    }

    .subtitle {
        text-align: center;
        color: #666;
        font-size: 14px;
        margin-bottom: 28px;
    }

    label {
        display: block;
        color: #333;
        font-weight: bold;
        font-size: 14px;
        margin-bottom: 8px;
    }

    input {
        width: 100%;
        padding: 13px;
        border: 1px solid #ccc;
        border-radius: 8px;
        font-size: 15px;
        margin-bottom: 19px;
        outline: none;
    }

    input:focus {
        border-color: #2e7d32;
        box-shadow: 0 0 0 3px rgba(46, 125, 50, 0.12);
    }

    .login-btn {
        width: 100%;
        padding: 14px;
        border: none;
        border-radius: 8px;
        background: #2e7d32;
        color: white;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        transition: background 0.2s;
    }

    .login-btn:hover {
        background: #1b5e20;
    }

    .error {
        padding: 11px;
        margin-bottom: 18px;
        border-radius: 7px;
        background: #ffebee;
        color: #b71c1c;
        font-size: 13px;
        text-align: center;
    }

    .demo {
        margin-top: 22px;
        padding: 13px;
        background: #f1f8e9;
        border-radius: 8px;
        color: #33691e;
        font-size: 13px;
        line-height: 1.8;
    }

    .demo strong {
        display: block;
        margin-bottom: 4px;
    }

    .footer {
        text-align: center;
        color: #888;
        font-size: 12px;
        margin-top: 22px;
    }

    .otp-input {
        text-align: center;
        font-size: 24px;
        letter-spacing: 8px;
    }

    .secondary {
        width: 100%;
        padding: 11px;
        margin-top: 10px;
        border: 1px solid #2e7d32;
        border-radius: 8px;
        background: #ffffff;
        color: #2e7d32;
        font-size: 14px;
        cursor: pointer;
    }

    .secondary:hover {
        background: #e8f5e9;
    }

    .info {
        text-align: center;
        font-size: 13px;
        color: #555;
        margin-bottom: 18px;
    }

    @media (max-width: 480px) {
        .login-container {
            padding: 25px 20px;
        }
    }
</style>
</head>

<body>

<div class="login-container">

    <div class="logo">🥛</div>

    <h1>Smart Dairy</h1>
    <p class="subtitle">Dairy Management System</p>

    <% if (!message.isEmpty()) { %>
        <div class="error">
            <%= message %>
        </div>
    <% } %>

    <% if (!otpStep) { %>

    <form action="<%= ctx %>/LoginServlet" method="post">

        <input type="hidden" name="action" value="send">

        <label for="mobile">Mobile Number</label>
        <input
            type="tel"
            id="mobile"
            name="mobile"
            placeholder="10 digit mobile number"
            inputmode="numeric"
            maxlength="14"
            autocomplete="username"
            required>

        <button type="submit" class="login-btn">
            Send OTP
        </button>

    </form>

    <% } else { %>

    <p class="info">
        OTP sent to <strong><%= OtpUtil.mask(otpMobile) %></strong>.
        It is valid for 5 minutes.
    </p>

    <form action="<%= ctx %>/LoginServlet" method="post">

        <input type="hidden" name="action" value="verify">

        <label for="otp">Enter OTP</label>
        <input
            class="otp-input"
            type="text"
            id="otp"
            name="otp"
            placeholder="------"
            inputmode="numeric"
            pattern="[0-9]{6}"
            maxlength="6"
            autocomplete="one-time-code"
            required
            autofocus>

        <button type="submit" class="login-btn">
            Verify &amp; Login
        </button>

    </form>

    <form action="<%= ctx %>/LoginServlet" method="post">
        <input type="hidden" name="action" value="send">
        <input type="hidden" name="mobile" value="<%= otpMobile %>">
        <button type="submit" class="secondary">Resend OTP</button>
    </form>

    <form action="<%= ctx %>/LoginServlet" method="post">
        <input type="hidden" name="action" value="reset">
        <button type="submit" class="secondary">Change mobile number</button>
    </form>

    <% if (devOtp != null) { %>
    <div class="demo">
        <strong>Testing mode</strong>
        Your OTP is: <b><%= devOtp %></b><br>
        (SMS is not connected yet. This box is shown only in testing mode.)
    </div>
    <% } %>

    <% } %>

    <div class="footer">
        &copy; 2026 Smart Dairy Management System
    </div>

</div>

</body>
</html>