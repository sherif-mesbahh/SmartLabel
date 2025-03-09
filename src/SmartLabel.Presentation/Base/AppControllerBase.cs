using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using System.Net;
using SmartLabel.Application.Bases;

namespace SmartLabel.Presentation.Base;

public class AppControllerBase : ControllerBase
{
	public ObjectResult NewResult<T>(Response<T> response)
	{
		switch (response.StatusCode)
		{
			case HttpStatusCode.OK:
				return new OkObjectResult(response);
			case HttpStatusCode.Created:
				return new CreatedResult(string.Empty, response);
			case HttpStatusCode.Unauthorized:
				return new UnauthorizedObjectResult(response);
			case HttpStatusCode.BadRequest:
				return new BadRequestObjectResult(response);
			case HttpStatusCode.NotFound:
				return new NotFoundObjectResult(response);
			case HttpStatusCode.Accepted:
				return new AcceptedResult(string.Empty, response);
			case HttpStatusCode.UnprocessableEntity:
				return new UnprocessableEntityObjectResult(response);
			default:
				return new BadRequestObjectResult(response);
		}
	}
}
