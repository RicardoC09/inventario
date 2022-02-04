<template>
    <div class="container-body">
        <div class="contenedor-tablas">
            <div class="card">
                <div class="card-header border-0">
                    <div class="row align-items-center">
                        <div class="col">
                            <h3 class="header-left">Menú Subexpediente</h3>
                            <h3 class="header-right">No.Expediente:7777</h3>
                        </div>
                        <!-- Boton lateral -->
                        <div class="col text-right">
                            <b-button
                                href="#/crearSubexpediente"
                                type="primary"
                                size="sm"
                                class="btn_table"
                            >Nuevo subexpediente</b-button
                            >
                        </div>
                    </div>
                </div>

                <div class="table-responsive">
                    <base-table thead-classes="thead-light" :data="tableData">
                        <template slot="columns">
                            <th>Código</th>
                            <th>No.Subexpediente</th>
                            <th>Descripción</th>
                            <th>Fecha creación</th>
                            <th>Fecha cierre</th>
                            <th>Cantidad de documentos</th>
                            <th>Estado</th>
                            <th></th>
                        </template>

                        <template slot-scope="{ row }">
                            <th scope="row">
                                {{ row.code }}
                            </th>
                            <td>
                                {{ row.noSubexpediente }}
                            </td>
                            <td>
                                {{ row.descripcion }}
                            </td>
                            <td>
                                {{ row.fechaCreacion }}
                            </td>
                            <td>
                                {{ row.fechaCierre }}
                            </td>
                            <td>
                                {{ row.cantidadDocumentos }}
                            </td>
                            <td>
                                {{ row.estado }}
                            </td>
                            <td class="text-right">
                                <base-dropdown class="dropdown" position="right">
                                    <a
                                        slot="title"
                                        class="btn btn-sm btn-icon-only text-light"
                                        role="button"
                                        data-toggle="dropdown"
                                        aria-haspopup="true"
                                        aria-expanded="false"
                                    >
                                        <i class="ni ni-bullet-list-67"></i>
                                    </a>

                                    <template>
                                        <a class="dropdown-item" href="#">Editar</a>
                                        <a class="dropdown-item" @click="showMsgBoxTwo">Eliminar</a>
                                        <a class="dropdown-item" href="#">Importar Documento</a>
                                    </template>
                                </base-dropdown>
                            </td>
                        </template>
                    </base-table>
                </div>
                <div
                    class="card-footer d-flex justify-content-end"
                    :class="type === 'dark' ? 'bg-transparent' : ''"
                >
                    <base-pagination total="30"></base-pagination>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    export default {
        name: "menuSubexpediente",
        data() {
            return {
                tableData: [
                    {
                        code: "1025",
                        noSubexpediente: "445",
                        descripcion: "Contrato",
                        fechaCreacion: "12/12/2020",
                        fechaCierre: "12/12/2021",
                        cantidadDocumentos: "2",
                        estado: "Abierto",
                    },
                    {
                        code: "1025",
                        noSubexpediente: "445",
                        descripcion: "Contrato",
                        fechaCreacion: "12/12/2020",
                        fechaCierre: "12/12/2021",
                        cantidadDocumentos: "2",
                        estado: "Abierto",
                    },
                    {
                        code: "1025",
                        noSubexpediente: "445",
                        descripcion: "Contrato",
                        fechaCreacion: "12/12/2020",
                        fechaCierre: "12/12/2021",
                        cantidadDocumentos: "2",
                        estado: "Abierto",
                    },
                    {
                        code: "1025",
                        noSubexpediente: "445",
                        descripcion: "Contrato",
                        fechaCreacion: "12/12/2020",
                        fechaCierre: "12/12/2021",
                        cantidadDocumentos: "2",
                        estado: "Abierto",
                    },
                    {
                        code: "1025",
                        noSubexpediente: "445",
                        descripcion: "Contrato",
                        fechaCreacion: "12/12/2020",
                        fechaCierre: "12/12/2021",
                        cantidadDocumentos: "2",
                        estado: "Abierto",
                    },
                ],
            };
        },
        // Modal eliminar
        methods: {
            showMsgBoxTwo() {
                this.boxTwo = "";
                this.$bvModal
                    .msgBoxConfirm("¿Eliminar subexpediente?", {
                        size: "sm",
                        text: "center",
                        buttonSize: "sm",
                        okVariant: "danger",
                        okTitle: "Aceptar",
                        cancelTitle: "Cancelar",
                        footerClass: "p-2",
                        hideHeaderClose: false,
                        centered: true,
                    })
                    .then((value) => {
                        this.boxTwo = value;
                    })
                    .catch((err) => {
                        // An error occurred
                    });
            },
        },
    };
</script>
<style scoped>
    .btn_table {
        background-color: #8f141b;
        color: #dfd4a6;
        border-radius: 50px;
    }
    .header-left {
        float: left;

    }
    .header-right {
        float: right;

    }
</style>
