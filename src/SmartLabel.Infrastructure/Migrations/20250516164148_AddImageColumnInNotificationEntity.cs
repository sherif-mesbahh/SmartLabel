using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SmartLabel.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class AddImageColumnInNotificationEntity : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Image",
                table: "Notifications",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Image",
                table: "Notifications");
        }
    }
}
