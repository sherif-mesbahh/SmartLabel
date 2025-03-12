using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SmartLabel.Infrastructure.Migrations
{
	/// <inheritdoc />
	public partial class AddBannerTableAndManyToManyRelationshipBetweenBannerAndProduct : Migration
	{
		/// <inheritdoc />
		protected override void Up(MigrationBuilder migrationBuilder)
		{
			migrationBuilder.CreateTable(
				name: "Banners",
				columns: table => new
				{
					Id = table.Column<int>(type: "int", nullable: false)
						.Annotation("SqlServer:Identity", "1, 1"),
					Title = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
					Description = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
					StartDate = table.Column<DateTime>(type: "datetime2", nullable: false),
					EndDate = table.Column<DateTime>(type: "datetime2", nullable: false)
				},
				constraints: table =>
				{
					table.PrimaryKey("PK_Banners", x => x.Id);
				});

			migrationBuilder.CreateTable(
				name: "BannerProducts",
				columns: table => new
				{
					Id = table.Column<int>(type: "int", nullable: false)
						.Annotation("SqlServer:Identity", "1, 1"),
					BannerId = table.Column<int>(type: "int", nullable: false),
					ProductId = table.Column<int>(type: "int", nullable: false)
				},
				constraints: table =>
				{
					table.PrimaryKey("PK_BannerProducts", x => x.Id);
					table.ForeignKey(
						name: "FK_BannerProducts_Banners_BannerId",
						column: x => x.BannerId,
						principalTable: "Banners",
						principalColumn: "Id",
						onDelete: ReferentialAction.Cascade);
					table.ForeignKey(
						name: "FK_BannerProducts_Products_ProductId",
						column: x => x.ProductId,
						principalTable: "Products",
						principalColumn: "Id",
						onDelete: ReferentialAction.Cascade);
				});

			migrationBuilder.CreateIndex(
				name: "IX_BannerProducts_BannerId",
				table: "BannerProducts",
				column: "BannerId");

			migrationBuilder.CreateIndex(
				name: "IX_BannerProducts_ProductId",
				table: "BannerProducts",
				column: "ProductId");
		}

		/// <inheritdoc />
		protected override void Down(MigrationBuilder migrationBuilder)
		{
			migrationBuilder.DropTable(
				name: "BannerProducts");

			migrationBuilder.DropTable(
				name: "Banners");
		}
	}
}
