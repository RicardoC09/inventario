<template>
    <div class="container">
        <div class="row">
            <div class="col">
                <div class="card" style="margin-top:6rem;">
                    <div class="card-header">
                        <div class="card-title"><h3>Expedientes</h3></div>
                    </div>
                    <div class="card-body">
                        <div v-if="rol != 'Usuario'">
                        <b-button v-b-modal.proceedings>Nuevo Expediente</b-button>
                        </div>  
                        <br>                  

                        <vue-bootstrap4-table :rows="rows_proceedings"
                                              :columns="columns_proceedings"
                                              :config="config" :classes="classes">
                            <template slot="eliminar" slot-scope="props">
                                <button class="btn btn-danger" title="Eliminar" @click="eliminar(props.row.proceedings)">
                                    🗑
                                </button>
                            </template>
                        </vue-bootstrap4-table>
                    </div>

                    
                    
                </div>
            </div>
        </div>
        <b-modal v-model="proceedings_modal" id="proceedings" size="lg" hide-footer>
            <div class="card">
                <div class="card-header">
                    <div class="card-title"><h3>Crear Expediente</h3></div>
                </div>
                <div class="card-body">
                    <b-form>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label>Sección:</label>
                                    <multiselect v-model="seccions" placeholder="Seleccione el filtro"
                                                 :options="options_seccions"
                                                 label="show_data"
                                                 @input="listSubSeccion(seccions.id)">
                                    </multiselect>
                                </div>
                                <div class="form-group">
                                    <label>Subsección:</label>
                                    <multiselect v-model="subSeccion" placeholder="Seleccione el filtro"
                                                 :options="options_subSeccion"
                                                 label="show_data"
                                                 @input="listSerie(subSeccion.id)">
                                    </multiselect>
                                </div>
                                <div class="form-group">
                                    <label>Serie:</label>
                                    <multiselect v-model="serie" placeholder="Seleccione el filtro"
                                                 :options="options_serie"
                                                 label="show_data"
                                                 @input="listSubserie(serie.id)">
                                    </multiselect>
                                </div>
                                <div class="form-group">
                                    <label>Subserie:</label>
                                    <multiselect v-model="subSerie" placeholder="Seleccione el filtro"
                                                 :options="options_subSerie"
                                                 label="show_data">
                                    </multiselect>
                                </div>
                                <div class="form-group">
                                    <label>Numero Del Expediente:</label>
                                    <input type="text"
                                           v-model="fileNumber"
                                           class="form-control">
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label>Nombre Del Expediente:</label>
                                    <input type="text"
                                           v-model="nameProceedings"
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
                                <div class="form-group">
                                    <label>Descripción:</label>
                                    <textarea name="" class="form-control"
                                              v-model="comment"
                                              id="approval_comment">
                                        </textarea>
                                </div>
                                <div class="container-button">
                                    <b-button class="btn-form-cancel">Cancelar</b-button>
                                    <b-button class="btn-form-submit" @click="setProceedings">Crear
                                    </b-button>
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
    import Multiselect from 'vue-multiselect';
    import VueBootstrap4Table from 'vue-bootstrap4-table';
    import swal from 'sweetalert';
    import axios from 'axios';

    export default {

        mounted() {
            this.listSeccion();
            this.litProccedingsAll();
            this.listUser();
        },
        name: "CrearExpediente",
        components: {Multiselect, swal, VueBootstrap4Table},
        data() {
            return {
                subSerie: '',
                comment: '',
                nameProceedings: '',
                openDate: '',
                fileNumber: '',
                seccions: '',
                subSeccion: '',
                serie: '',
                proceedings_modal: false,
                rol:'',
                btneliminar:'',
                id:'',

                filter: [],
                options_subSerie: [],
                options_seccions: [],
                options_subSeccion: [],
                options_serie: [],

                options_action_date: {
                    format: 'YYYY-MM-DD',
                    useCurrent: false,
                },
                rows_proceedings: [],
                columns_proceedings: [

                    {
                        label: "Eliminar",
                        name: "eliminar",
                        slot_name: "eliminar"
                    },
                   {
                        label: "# Expediente",
                        name: "proceedings",
                    },
                    {
                        label: "Sección",
                        name: "seccions",
                        sort: true,
                    }, {
                        label: "Subsección",
                        name: "subSections",
                    },
                    {
                        label: "Serie",
                        name: "serie",
                    }, {
                        label: "Subserie",
                        name: "subSerie",
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

            };
        },
        methods: {
            messageAlert: function (state, title, msj) {
                this.$swal({
                    type: state,
                    title: title,
                    text: msj
                });
            },

            listSeccion: function () {
                axios.get('/getSeccions').then(response => {
                    this.filter = response.data;
                    console.log(this.filter);
                    let data = this.filter;
                    let aux = '';
                    let section = [];
                    for (let i in data) {
                        if (aux !== data[i].seccions_id){
                            section.push({
                                'id': data[i].seccions_id,
                                'name': data[i].seccions,
                                show_data: [data[i].seccions_code, data[i].seccions]
                            });
                        }
                        aux = data[i].seccions_id;
                    }
                    this.options_seccions = section;
                }).catch(e => {
                    console.log(e.response);
                });
            },
            listSubSeccion: function (seccion_id) {
                let data = this.filter;
                let subseccion = [];
                let aux = '';
                for (let i in data){
                    if(seccion_id == data[i].seccions_id){
                        if(aux !== data[i].seccions_id){
                            subseccion.push({
                                'id': data[i].sub_seccion_id,
                                'name': data[i].sub_seccion,
                                show_data: [data[i].subsection_code, data[i].sub_seccion]
                            });
                        }
                        aux = data[i].sub_seccion_id
                    }
                }
                this.options_subSeccion = subseccion;
            },

            listSerie: function (sub_seccion_id){
                let data = this.filter;
                let serie  = [];
                let aux = '';
                for (let i in data){
                    if(sub_seccion_id == data[i].sub_seccion_id){
                       if(aux !== data[i].sub_seccion_id){
                           serie.push({
                               'id': data[i].serie_id,
                               'name': data[i].series,
                               show_data: [data[i].serie_code, data[i].series]
                           })
                       }
                       aux = data[i].serie_id;
                    }
                }
                this.options_serie = serie;
            },

            listSubserie: function (serie_id){
                let data = this.filter;
                let subserie = [];
                let aux = '';
                for (let i in data){
                    if(serie_id == data[i].serie_id){
                        console.log(aux);
                        if (aux !== data[i].serie_id){
                            subserie.push({
                                'id': data[i].sub_series_id,
                                'name': data[i].sub_series,
                                show_data: [data[i].subserie_code, data[i].sub_series]
                            })
                        }
                        aux = data[i].sub_series_id;
                    }
                }
                this.options_subSerie = subserie;
            },

            litProccedingsAll: function () {
                axios.get('/getProccedingsAll').then(response =>{
                    let data = response.data;
                    for (let i in data){
                        this.rows_proceedings.push({
                            'No': data[i].id_proccedings,
                            'seccions': data[i].seccions,
                            'subSections': data[i].subSections,
                            'serie': data[i].serie,
                            'subSerie': data[i].subSerie,
                            'proceedings': data[i].numberProceedings,
                            'name': data[i].proceedings,
                            'description': data[i].description,
                            'state': data[i].state,
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

            setProceedings: function () {
                let formData = {
                    'subSerie': this.subSerie.id,
                    'comment': this.comment,
                    'nameProceedings': this.nameProceedings,
                    'openDate': this.openDate,
                    'fileNumber': this.fileNumber
                };
                axios.post('/setProceedings', formData).then(response => {
                    this.proceedings_modal = false;
                    let data = response.data;
                    if (data == true) {
                        this.messageAlert('success', 'Buen trabajo', 'Se ha creado exitosamente el expediente.');
                        window.location.reload();
                    }
                }).catch(e => {
                    console.log(e.response);
                });
            },
            eliminar: function (proceedings){
                swal({
                    title: 'Seguro de eliminar el registro ' +proceedings+ ' ?',
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: '#d33',
                    cancelmButtonColor: '#3085d6',
                    confirmButtonText: 'Borrar',
                }).then((result) => {
                    if (result){
                        console.log(proceedings)
                        console.log("hola")
                        axios.delete('/deleteproceedings/' + proceedings).then(res=>{
                            this.litProccedingsAll()
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
        top: 20px;
        text-align: center;
    }

    .text-bcard {
        text-align: left;
    }
</style>