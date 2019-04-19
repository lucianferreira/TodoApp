using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ToDoApp.Domain.Entities;
using ToDoApp.Domain.Filters;

namespace ToDoApp.Domain.Repositories
{
    public interface ITodoRepository : IRepository<Entities.Todo, Filters.TodoFilter>
    {
       
    }
}
