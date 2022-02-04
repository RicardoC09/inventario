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
                            <h3 class="mb-0">Documentos</h3>
                        </div>
                        <div class="card-body">
                            <div v-if="rol != 'Usuario'">
                            <b-button v-b-modal.documents>Nuevo Documento</b-button>
                            </div>
                            <vue-bootstrap4-table :rows="rows_documents"
                                                  :columns="columns_documents"
                                                  :config="config" :classes="classes">
                                <template slot="eliminar" slot-scope="props">
                                <button class="btn btn-danger" title="Eliminar" @click="eliminardocument(props.row.name)">
                                    🗑
                                </button>
                                </template>
                                <template slot="tracing_LOG" slot-scope="props">
                                    <div v-if="props.cell_value[2] == null">
                                            <b-button-group>
                                                <a :href="'soportes/expediente/' + props.cell_value[0]"
                                                    data-toggle="tooltip"
                                                    data-placement="top"
                                                    title="Descargar Soporte">
                                                    <i  :link="{
                                                            icon: 'ni ni-ruler-pencil text-orange',                            
                                                        }" aria-hidden="true"></i>
                                                    <sidebar-item
                                                        :link="{
                                                            icon: 'ni ni-ruler-pencil text-orange',                            
                                                        }"
                                                    />
                                                </a>
                                            </b-button-group>
                                    </div>
                                    <div v-else>
                                        <b-button-group>
                                            <a :href="'soportes/expediente/subexpediente/' + props.cell_value[0]"
                                                data-toggle="tooltip"
                                                data-placement="top"
                                                title="Descargar Soporte">
                                                    <sidebar-item
                                                        :link="{
                                                            icon: 'ni ni-ruler-pencil text-orange',                            
                                                        }"
                                                    />
                                            </a>
                                        </b-button-group>
                                    </div>
                                </template>
                            </vue-bootstrap4-table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <b-modal v-model="documents_modal" id="documents" size="lg" hide-footer>
            <div class="card">
                <div class="card-header">
                    <div class="card-title"><h3>Documento Nuevo</h3></div>
                </div>
                <div class="card-body">
                    <b-form>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label>Nombre de Expediente:</label>
                                    <multiselect v-model="fileNumber" placeholder="Seleccione el filtro"
                                                 :options="options_fileNumber"
                                                 label="show_data"
                                                 @input="listSubProccedings(fileNumber.id)">
                                    </multiselect>
                                </div>
                                <div v-if="state === true">
                                    <div class="form-group">
                                        <label>Numero de Subexpediente:</label>
                                        <multiselect v-model="subFileNumber" placeholder="Seleccione el filtro"
                                                     :options="options_subFileNumber"
                                                     label="show_data">
                                        </multiselect>
        
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Nombre Del Documento:</label>
                                    <input type="text"
                                           v-model="nameDocument"
                                           class="form-control">
                                </div>
                                <b-form-group id="fieldset-5" label="Fecha de Creacion:">
                                    <b-form-input id="input-3"
                                                  v-model="documentDate"
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
                                <div>
                                    <b-form-group id="fieldset-6" label="Subir archivos pdf:">
                                        <b-form-file
                                            v-model="file"
                                            :state="Boolean(file)"
                                            placeholder="Choose a file or drop it here..."
                                            drop-placeholder="Drop file here..."
                                            @change="fileChange">
                                        </b-form-file>
                                    </b-form-group>
                                </div>
                                <div class="container-button">
                                    <b-button class="btn-form-cancel">Cancelar</b-button>
                                    <b-button class="btn-form-submit" @click="setDocumente">Crear</b-button>
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
    import VueBootstrap4Table from "vue-bootstrap4-table";
    import Multiselect from 'vue-multiselect';
    import swal from 'sweetalert';
    import axios from 'axios';

    export default {
        mounted() {
            this.listProceedings();
            this.listDocument();
            this.listUser();
        },
        components: {Multiselect, swal, VueBootstrap4Table},
        name: "crearDocumento",
        data() {
            return {
                file: null,
                fileNumber: '',
                subFileNumber: '',
                nameDocument: '',
                documentDate: '',
                comment: '',
                proceedings: '',
                subproceedings: '',
                documents_modal: false,
                state: false,
                rol:'',
                soporte:'',
                id:'',

                options_fileNumber: [],
                options_subFileNumber: [],

                rows_documents: [],
                columns_documents: [
                    {
                        label: "Eliminar",
                        name: "eliminar",
                        slot_name: "eliminar"
                    },
                    {
                        label: "Expediente",
                        name: "proceedings",
                    },
                    {
                        label: "# Subexpediente",
                        name: "subproceedings",
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
                        label: "Fecha",
                        name: "date_document",
                    },
                    {
                        label: "Estado",
                        name: "state",
                        sort: true,
                    },
                    {
                        label: "LOG",
                        name: "tracing_LOG",
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

            listProceedings: function () {
                axios.get('/getProceedings').then(response => {
                    this.proceedings = response.data;
                    for (let i in this.proceedings) {
                        this.options_fileNumber.push({
                            'id': this.proceedings[i].id,
                            'name': this.proceedings[i].name,
                            'show_data':[this.proceedings[i].fileNumber, this.proceedings[i].name]
                        });
                    }
                }).catch(e => {
                    console.log(e.response);
                });
            },

            listDocument: function (){
                axios.get('/getDocument').then(response => {
                    let data = response.data;
                    let json = [];
                    for (let i in data){
                        let formData = {
                            proceedings: data[i].proceedings,
                            subproceedings: data[i].subproceedings,
                            support:data[i].support
                        };
                        json.push(formData);
                        let proceedings = data[i].proceedings;
                        let subproceedings = data[i].subproceedings;
                        this.rows_documents.push({
                            'No':  data[i].documents_id,
                            'proceedings': data[i].proceedings,
                            'subproceedings': data[i].subproceedings,
                            'name': data[i].documents,
                            'description': data[i].description,
                            'date_document': data[i].date_document,
                            'state': data[i].state,
                            'tracing_LOG':[data[i].support, proceedings, subproceedings]
                        });
                    }
                    this.soporte = json;
                    
                }).catch(e => {
                    console.log(e.response);
                });
            },

            listSubProccedings: function (proceedingsId) {
                this.state = false;
                axios.get('/getSubProccedings/' + proceedingsId).then(response => {
                    this.options_subFileNumber = [];
                    this.subFileNumber = '';
                    this.subproceedings = response.data;
                    for (let i in this.subproceedings) {
                        if (this.subproceedings === null) {
                            this.state = false;
                        } else {
                            this.state = true;
                        }
                        this.options_subFileNumber.push({
                            'id': this.subproceedings[i].id,
                            'name': this.subproceedings[i].name,
                            'show_data': [this.subproceedings[i].subFileNumber, this.subproceedings[i].name]
                        })
                    }
                    console.log(this.options_subFileNumber);
                }).catch(e => {
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

            fileChange: function (e) {
                this.file = e.target.files[0];
            },

            setDocumente: function () {
                let formData = new FormData();
                formData.append('fileNumber', this.fileNumber.id);
                formData.append('subFileNumber', this.subFileNumber.id);
                formData.append('nameDocument', this.nameDocument);
                formData.append('documentDate', this.documentDate);
                formData.append('comment', this.comment);
                formData.append('file', this.file);
                const config = {
                    headers: {'content-type': 'multipart/form-data'}
                };
                axios.post('/setDocumente', formData, config).then(response => {
                    this.documents_modal = false;
                    let data = response.data;
                    if (data == true){
                        this.messageAlert('success', 'Buen trabajo!', 'Se ha creado exitosamente el Documento.');
                        window.location.reload();
                    }else {
                        this.messageAlert('info', 'Información', 'Algunos datos tuvieron conflito con el sistema. Intente de nuevo.');
                    }
                }).catch(e => {
                    console.log(e.response);
                });


            },
            eliminardocument: function (name){
                swal({
                    title: 'Seguro de eliminar el registro ' +name+ ' ?',
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: '#d33',
                    cancelmButtonColor: '#3085d6',
                    confirmButtonText: 'Borrar',
                }).then((result) => {
                    if (result){
                        console.log(name)
                        console.log("hola")
                        axios.delete('/deletedocument/' + name).then(res=>{
                            this.listDocument()
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

            },
        },
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
        top: 25px;
        text-align: center;
    }

    .header-left {
        float: left;
        font-size: 1rem;
        font-weight: 400;
        line-height: 1.5;
        color: #525f7f;
    }

    .header-right {
        float: right;
        font-size: 1rem;
        font-weight: 400;
        line-height: 1.5;
        color: #525f7f;
    }
</style>
