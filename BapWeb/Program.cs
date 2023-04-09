using BAP.WebCore;
using NLog;

var builder = WebApplication.CreateBuilder(args);
// Add services to the container.
builder.Services.AddRazorPages();
builder.Services.AddServerSideBlazor();
builder.Services.AddMvc();
builder.Services.AddControllers();
builder.AddAllAddonsAndRequiredDiServices();


var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
}
app.SetupPostDIBapServices();

app.UseHttpsRedirection();

app.UseStaticFiles();
app.MapControllers();
app.UseRouting();

app.MapBlazorHub();
app.MapFallbackToPage("/_Host");

app.Run();
