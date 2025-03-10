using MediatR;
using Microsoft.AspNetCore.Mvc;
using SmartLabel.Presentation.Base;
using SmartLabel.Presentation.Services;

namespace SmartLabel.Presentation.Controllers;

[Route("api/[controller]")]
[ApiController]
public class ProductController(IMediator mediator, IFileService fileService) : AppControllerBase
{

}
