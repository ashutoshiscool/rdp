# Use the base Dockerfile for Windows
FROM dockur/windows:latest

# Set environment variables for Cloudflare Tunnel
ENV TUNNEL_TOKEN=eyJhIjoiNDE1NTQyNmYwYzExYWE3MDA2NjBhZDFmMmQ5MzcwYWUiLCJ0IjoiZjM0MTRjOWYtNTc1MC00Zjg4LWFmNDUtZGY3ZmQ2YmEwZmI4IiwicyI6Ik1XRTFOamxsTXpVdE5EUTVNeTAwTTJFekxUazNOall0T1RJeE1qQXlOVGt5WXpoayJ9

# Download and install cloudflared in Windows environment
RUN powershell.exe -Command \
    Invoke-WebRequest -Uri https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-windows-amd64.exe -OutFile cloudflared.exe; \
    Move-Item -Path cloudflared.exe -DestinationPath C:\\cloudflared.exe

# Set the working directory
WORKDIR C:\

# Expose necessary ports (e.g., 80 for HTTP, 3389 for RDP)
EXPOSE 80
EXPOSE 3389

# Set cloudflared tunnel to run when the container starts
CMD ["C:\\cloudflared.exe", "tunnel", "--no-autoupdate", "run", "--token", "%TUNNEL_TOKEN%"]
