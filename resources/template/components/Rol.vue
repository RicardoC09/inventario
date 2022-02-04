<template>
<div class="container-body">
    <div class="contenedor-tablas">
        <div class="card">
    <div class="card-header border-0">
      <div class="row align-items-center">
        <div class="col">
          <h3 class="mb-0">Roles</h3>
        </div>
         <!-- Boton lateral -->
         <!--<div class="col text-right">
          <base-button type="primary" size="sm" class="btn_table">Menú expedientes</base-button>
        </div>-->
      </div>
    </div>

    <div class="table-responsive">
      <base-table thead-classes="thead-light"
                  :data="tableData">
        <template slot="columns">
          <th>Nombre rol</th>
          <th>Descripción</th>
          <th>No. usuarios</th>
          <th>Permisos</th>
          <th></th>
        </template>

        <template slot-scope="{row}">
          <th scope="row">
            {{row.name}}
          </th>
          <td>
            {{row.description}}
          </td>
          <td>
            {{row.users}}
          </td>
          <td>
            {{row.permits}}
          </td>
          <td class="text-right">
            <base-dropdown class="dropdown"
                           position="right">
              <a slot="title" class="btn btn-sm btn-icon-only text-light" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="ni ni-bullet-list-67"></i>
              </a>

              <template>
                <a class="dropdown-item" href="#">Usuarios</a>
                <a class="dropdown-item" href="#">Editar</a>
                <a class="dropdown-item" href="#">Desactivar</a>
              </template>
            </base-dropdown>
          </td>
        </template>

      </base-table>
    </div>
<div class="card-footer d-flex justify-content-end"
         :class="type === 'dark' ? 'bg-transparent': ''">
      <base-pagination total="30"></base-pagination>
    </div>
  </div>
    </div>
</div>
    
</template>
<script>
export default {
     name: 'rol',
     data() {
      return {
        tableData: [
          {
            name: 'Super Administrador',
            description: 'Super Usuario',
            users: '2',
            permits: '3',
          },
          {
           name: 'Administrador',
            description: 'Super Usuario',
            users: '0',
            permits: '3',
          },
          {
            name: 'Usuario',
            description: 'Usuario',
            users: '0',
            permits: '1',
          }
        ]
      }
    }
}
</script>
<style scoped>
.btn_table{
  background-color: #8F141B;
  color: #DFD4A6;
  border-radius: 50px;
}
</style>