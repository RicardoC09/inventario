<template>
    <div>
        <base-header type="gradient-success" class="pb-6 pb-8 pt-5 pt-md-8">
            <!-- Card stats -->
            <div class="row">
            </div>
        </base-header>
        <div class="container-fluid mt--7">
            <div class="row">
                <div class="col">
                    <div class="card shadow">
                        <div class="card-header bg-transparent">
                            <h3 class="mb-0">Subexpediente</h3>
                        </div>
                        <div class="card-body">
                            <div v-if="rol != 'Usuario'">
                                <b-button v-b-modal.subproceedings>Nuevo Subxpediente</b-button>
                            </div>
                            <vue-bootstrap4-table :rows="rows_subproceedings"
                                                  :columns="columns_subproceedings"
                                                  :config="config" :classes="classes">
                                <template slot="eliminar" slot-scope="props">
                                <button class="btn btn-danger" title="Eliminar" @click="eliminarsubex(props.row.subproceedings)">
                                    🗑
                                </button>
                            </template>
                            </vue-bootstrap4-table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <b-modal v-model="subproceedings_modal" id="subproceedings" size="lg" hide-footer>
            <div class="card">
                <div class="card-header">
                    <div class="card-title"><h3>Crear Subexpediente</h3></div>
                </div>
                <div class="card-body">
                    <b-form>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label>Expediente:</label>
                                    <multiselect v-model="proceedings" placeholder="Seleccione el filtro"
                                                 :options="options_proceedings"
                                                 label="show_data">
                                    </multiselect>
                                </div>
                                <div class="form-group">
                                    <label>Numero Del Subxpediente:</label>
                                    <input type="text"
                                           v-model="subFileNumber"
                                           class="form-control">
                                </div>
                                <div class="form-group">
                                    <label>Nombre Del Subexpediente:</label>
                                    <input type="text"
                                           v-model="nameSubProceedings"
                                           class="form-control">
                                </div>
                                <b-form-group id="fieldset-5" label="Fecha de Creacion:">
                                    <b-form-input id="input-3"
                                                  v-model="openDate"
                                                  type="date"
                                                  required
                                                  placeholder="aaaa/mm/dd">
                                    </b-form-input>
                                </b-form-group>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label>Descripción:</label>
                                    <textarea name="" class="form-control"
                                              v-model="comment"
                                              id="approval_comment">
                                    </textarea>
                                </div>
                                <div class="container-button">
                                    <b-button class="btn-form-cancel">Cancelar</b-button>
                                    <b-button class="btn-form-submit" @click="setSubProceedings">Crear</b-button>
                                </div>
                            </div>
                        </div>
                    </b-form>
                </div>
            </div>
        </b-modal>
    </div>
</template>
<script>

    import Multiselect from "vue-multiselect";
    import swal from "sweetalert";
    import VueBootstrap4Table from "vue-bootstrap4-table";
    import axios from 'axios';

    export default {
        mounted() {
            this.listProceedings();
            this.listSubproceedingsAll();
            this.listUser();
        },
        components: {Multiselect, swal, VueBootstrap4Table},
        name: "crearSubexpediente",
        data() {
            return {
                proceedings: '',
                subFileNumber: '',
                nameSubProceedings: '',
                openDate: '',
                comment: '',
                subproceedings_modal: false,

                options_proceedings: [],


                rows_subproceedings: [],
                columns_subproceedings: [
                    {
                        label: "Eliminar",
                        name: "eliminar",
                        slot_name: "eliminar"
                    },
                    {
                        label: "# Subexpediente",
                        name: "subproceedings",
                    },
                    {
                        label: "Expediente",
                        name: "proceedings",
                    },
                   
                    {
                        label: "Nombre",
                        name: "name",
                    },
                    {
                        label: "Descripción",
                        name: "description",
                    },
                    {
                        label: "Estado",
                        name: "state",
                        sort: true,
                    },
                ],
                config: {
                    show_refresh_button: false,
                    show_reset_button: false,
                    card_mode: false,
                    per_page: 5,
                },
                classes: {
                    table: {
                        "table table-striped table-striped-bg-default mt-3": true,
                    },
                },
            }
        },
        methods: {
            messageAlert: function (state, title, msj) {
                this.$swal({
                    type: state,
                    title: title,
                    text: msj
                });
            },

            listProceedings: function () {
                axios.get('/getProceedings').then(response=>{
                    let proceedings = response.data;
                    for (let i in proceedings){
                        this.options_proceedings.push({
                            'id':proceedings[i].id,
                            'name':proceedings[i].name,
                            'show_data':[proceedings[i].fileNumber, proceedings[i].name],
                        })
                    }
                }).catch(e =>{
                    console.log(e.response);
                });
            },

            listSubproceedingsAll: function (){
                axios.get('/get_subproccedings_all').then(response=>{
                    let data = response.data;
                    for(let i in data){
                        this.rows_subproceedings.push({
                            'No': data[i].sub_proceedings_id,
                            'proceedings':data[i].proceedings,
                            'subproceedings':data[i].subfile_number,
                            'name':data[i].sub_proceedings,
                            'description':data[i].description,
                            'state':data[i].state,
                        });
                    }
                }).catch(e =>{
                    console.log(e.response);
                });
            },

            listUser:function (){
                axios.get('/getUser').then(response => {
                    let data = response.data;
                    console.log('Yo soy el alfa y la omega');
                    console.log(data);
                    for(let i in data){
                        this.rol= data[i].rol;
                    }
                     }).catch(e => {
                    console.log(e.response);
                });
            },

            setSubProceedings: function() {
                let formData = {
                    'proceedingsId': this.proceedings.id,
                    'subFileNumber': this.subFileNumber,
                    'nameSubProceedings': this.nameSubProceedings,
                    'comment': this.comment,
                    'openDate': this.openDate,
                };
                axios.post('/setSubProceedings', formData).then(response => {
                    this.subproceedings_modal = false;
                    let data = response.data;
                    if (data == true) {
                        this.messageAlert('success', 'Buen trabajo', 'Se ha creado exitosamente el subexpediente.');
                        window.location.reload();
                        this.proceedings = '';
                        this.subFileNumber = '';
                        this.nameSubProceedings = '';
                        this.comment = '';
                        this.openDate = '';
                        
                    }
                }).catch(e => {
                    console.log(e.response);
                });
            },
            eliminarsubex: function (subproceedings){
                swal({
                    title: 'Seguro de eliminar el registro ' +subproceedings+ ' ?',
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: '#d33',
                    cancelmButtonColor: '#3085d6',
                    confirmButtonText: 'Borrar',
                }).then((result) => {
                    if (result){
                        console.log(subproceedings)
                        console.log("hola")
                        axios.delete('/deletesubproceedings/' + subproceedings).then(res=>{
                            this.listSubproceedingsAll()
                            swal("Eliminado","Registro Eliminado", "success");
                            window.location.reload();
                        }).catch(function(error){
                            console.log(error)
                            var array = Object.values(error.response.data.errors)
                            array.forEach(element => swal(String(element)))
                        });
                        swal("Registro Eliminado", {
                            icon: "success",
                        });

                        /*this.delete_proceedings(fileNumber);
                        swal("Registro eliminado",
                            "Eliminado", 
                            "success"
                        )*/
                    }
                    
                })

            }
        }
    };
</script>
<style scoped>
    .bg-gradient-success {
        background: linear-gradient(87deg, #8f141b 0, #8f141b 100%) !important;
    }
    .container-card {
        width: 50%;
    }

    .btn-form-submit {
        background-color: #8f141b;
        color: #dfd4a6;
        border-radius: 20px;
        width: 30%;
    }

    .btn-form-cancel {
        background-color: #dfd4a6;
        color: #8f141b;
        border-radius: 20px;
        width: 30%;
    }

    .form-group-left {
        width: 60%;
        text-align: left;
    }

    .form-group-right {
        width: 100%;
        text-align: left;
    }

    .container-right {
        float: right;
        width: 50%;
    }

    .container-left {
        float: left;
        width: 50%;
    }

    .container-button {
        position: relative;
        top: 60px;
        text-align: center;
    }

    .text-bcard {
        text-align: left;
    }
</style>
