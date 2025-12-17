using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace HomeBoard.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class AddNotesAndPhotoUrlToTaskCompletion : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Notes",
                table: "TaskCompletions",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "PhotoUrl",
                table: "TaskCompletions",
                type: "text",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Notes",
                table: "TaskCompletions");

            migrationBuilder.DropColumn(
                name: "PhotoUrl",
                table: "TaskCompletions");
        }
    }
}
