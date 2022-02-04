<template>
    <div>
        <base-header type="gradient-success" class="pb-6 pb-8 pt-5 pt-md-8">
            <!-- Card stats -->
            <div class="row">
            </div>
        </base-header>

        <div class="container-fluid mt--7">
            <div class="row">
                <div class="col-xl-4 order-xl-2 mb-5 mb-xl-0">
                    <div class="card card-profile shadow">
                        <div class="row justify-content-center" style="margin-top:3rem;">
                            <div class="col-lg-3 order-lg-2">
                                <div class="card-profile-image">
                                    <a href="#">
                                        <img :src="'avatar/' + avatar" width="100" height="100" class="rounded-circle">
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="card-header text-center border-0 pt-8 pt-md-4 pb-0 pb-md-4">
                            <div class="d-flex justify-content-between">
                                <base-button size="sm" type="info" class="mr-4">Connect</base-button>
                                <base-button size="sm" type="default" class="float-right">Message</base-button>
                            </div>
                        </div>
                        <div class="card-body pt-0 pt-md-4">
                            <div class="row">
                                <div class="col">
                                    <div class="card-profile-stats d-flex justify-content-center mt-md-5">
                                        <div>
                                            <span  v-text="idPeple" class="heading"></span>
                                            <span class="description">Usuario</span>
                                        </div>
                                        <div>
                                            <span v-text="rolId" class="heading"></span>
                                            <span class="description">Rol</span>
                                        </div>
                                        <div>
                                            <span  v-text="cargo" class="heading"></span>
                                            <span class="description">Cargo</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="text-center">
                                <h4>
                                    <i class="ni business_briefcase-24 mr-2"><span v-text="nameUser" class="font-weight-light"></span></i>
                                </h4>
                                <div class="h5 font-weight-300">
                                     <i class="ni business_briefcase-24 mr-2"><span v-text="taypeDocument" class="font-weight-light"></span></i>
                                </div>
                                <div class="h5 font-weight-300">
                                     <i class="ni business_briefcase-24 mr-2"><span v-text="number" class="font-weight-light"></span></i>
                                </div>
                                <div class="h5 mt-4">
                                    <i class="ni business_briefcase-24 mr-2"><span v-text="email_user" class="font-weight-light"></span></i>
                                </div>
                                <hr class="my-4"/>
                                <div class="h5 font-weight-300">
                                     <i class="ni business_briefcase-24 mr-2"><span v-text="positionUser" class="font-weight-light"></span></i>
                                </div>
                                <div class="h5 mt-4">
                                    <i class="ni business_briefcase-24 mr-2"><span v-text="rol" class="font-weight-light"></span></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xl-8 order-xl-1">
                    <card shadow type="secondary">
                        <div slot="header" class="bg-white border-0">
                            <div class="row align-items-center">
                                <div class="col-8">
                                    <h3 class="mb-0">Usuarios</h3>
                                </div>
                                <div v-if="rol != 'Usuario'">
                                    <div>
                                        <b-button v-b-modal.modal_user>Nuevo usuario</b-button>
                                    </div>
                                </div>        
                            </div>
                        </div>
                        <div class="card-body">
                             <vue-bootstrap4-table :rows="rows_users"
                                                  :columns="columns_users"
                                                  :config="config" :classes="classes">
                            </vue-bootstrap4-table>                            
                        </div>
                    </card>
                </div>
            </div>
        </div>
         <!-- Modal New User-->
        <b-modal v-model="modal_user" id="modal_user" size="lg" hide-footer>
            <div class="card">
                <div class="card-header">
                    <div class="card-title"><h3>Nuevo Usuario</h3></div>
                </div>
                <div class="card-body">
                    <b-form>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="documenType">Tipo de Documento:</label>
                                    <multiselect v-model="documenType"
                                                 id="documenType"
                                                 placeholder="Seleccione el tipo de documento"
                                                 :options="options_documenType"
                                                 label="name">
                                    </multiselect>
                                </div>
                                <div class="form-group">
                                    <label for="documentNunber">Numero de documento:</label>
                                    <input type="text"
                                           id="documentNunber"
                                           v-model="documentNunber"
                                           class="form-control">
                                </div>
                                <div class="form-group">
                                    <label for="name">Nombre y Apellidos:</label>
                                    <input type="text"
                                           id="name"
                                           v-model="name"
                                           class="form-control">
                                </div>
                                 <div class="form-group">
                                    <label for="email">Email:</label>
                                    <b-form-input type="email"
                                           id="email"
                                           v-model="email">
                                    </b-form-input>
                                </div>
                                <div class="form-group">
                                    <label for="rolType">Seleccione el Rol:</label>
                                    <multiselect v-model="rolType"
                                                 placeholder="Seleccione el Rol"
                                                 :options="options_rolType"
                                                 label="name"
                                                 id="rolType">
                                    </multiselect>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="position">Seleccione el Cargo:</label>
                                    <multiselect v-model="position"
                                                 placeholder="Seleccione el cargo"
                                                 :options="options_position"
                                                 label="name"
                                                 id="position">
                                    </multiselect>
                                </div>
                                <div class="form-group">
                                    <label for="password">Ingrese una contraseña:</label>
                                    <b-form-input type="password"
                                           id="password"
                                           v-model="password">
                                    </b-form-input>
                                </div>
                                <div class="form-group">
                                    <label for="password1">Comprobar contraseña:</label>
                                    <b-form-input type="password"
                                           id="password1"
                                           v-model="password1">
                                    </b-form-input>
                                </div>
                                <div>
                                    <b-form-group id="fieldset-6" label="Subir imagen:">
                                        <b-form-file
                                            v-model="file"
                                            :state="Boolean(file)"
                                            placeholder="Choose a file or drop it here..."
                                            drop-placeholder="Drop file here..."
                                            @change="fileChange">>
                                        </b-form-file>
                                    </b-form-group>
                                </div>
                                <div v-if="password != password1">
                                    <h4><i class="ni business_briefcase-24 mr-2">{{contraseña}}</i></h4>
                                </div>
                                <div v-if=" (documenType != '' && documentNunber != '' && name != '' && email != '' && rolType != '' && position != '' && avatar != '') && password == password1">
                                    <div class="container-button">
                                        
                                        <b-button class="btn-form-submit" @click="setUserNew">Crear</b-button>
                                    </div>
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
           this.listUser();
           this.listUsers();
           this.listDocumentTypes();
           this.listPositions();
           this.listRoles();
        },
        components: {Multiselect, swal, VueBootstrap4Table},
        name: "Usuarios",
        data() {
            return {
                modal_user: false,
                documenType:'',
                rolType:'',
                documentNunber:'',
                position:'',
                name:'',
                email:'',
                password:'',
                password1:'',
                file:null,
                nameUser:'',
                idPeple:'',
                taypeDocument:'',
                number:'',
                rol:'',
                rolId:'',
                positionUser:'',
                cargo:'',
                email_user:'',
                avatar:'',
                contraseña:'Las contraseñas no son iguales',


                options_documenType:[],
                options_rolType:[],
                options_position:[],

                rows_users: [],
                columns_users: [
                    {
                        label: "ID",
                        name: "id",
                    },
                    {
                        label: "Nombre",
                        name: "name",
                        sort: true,
                    },
                    {
                        label: "Email",
                        name: "email",
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
            listUser:function (){
                axios.get('/getUser').then(response => {
                    let data = response.data;
                    for(let i in data){
                        this.idPeple= data[i].idPeple;
                        this.taypeDocument= data[i].taypeDocument;
                        this.number= data[i].number;
                        this.rol= data[i].rol;
                        this.rolId= data[i].rolId;
                        this.positionUser= data[i].position;
                        this.cargo= data[i].cargo;
                        this.email_user= data[i].email;
                        this.avatar= data[i].avatar;
                        this.nameUser = data[i].nameUser;
                    }
                     }).catch(e => {
                    console.log(e.response);
                });
            },
            listUsers:function (){
                axios.get('/getUsers').then(response => {
                    let data = response.data;
                    for (let i in data){
                        this.rows_users.push({
                            'id': data[i].idPeple,
                            'name': data[i].nameUser,
                            'email': data[i].email,
                        });
                    }
                }).catch(e => {
                    console.log(e.response);
        
                });
            },
            listDocumentTypes: function () {
                axios.get('/getDocumentTypes').then(response => {
                    let data = response.data;
                    console.log('Yo Soy el que soy');
                    console.log(data);
                    for (let i in data) {
                        this.options_documenType.push({
                            'id': data[i].id,
                            'name': data[i].name,
                        });
                    }
                }).catch(e => {
                    console.log(e.response);
                });
            },
            listPositions: function () {
                axios.get('/getPositions').then(response => {
                    let data = response.data;
                    for (let i in data) {
                        this.options_position.push({
                            'id': data[i].id,
                            'name': data[i].name,
                        });
                    }
                }).catch(e => {
                    console.log(e.response);
                });
            },
            listRoles: function () {
                axios.get('/getRoles').then(response => {
                    let data = response.data;
                    for (let i in data) {
                        this.options_rolType.push({
                            'id': data[i].id,
                            'name': data[i].name,
                        });
                    }
                }).catch(e => {
                    console.log(e.response);
                });
            },

            fileChange: function (e) {
                this.file = e.target.files[0];
            },

            setUserNew: function () {
                let formData = new FormData();
                formData.append('documenType', this.documenType.id);
                formData.append('documentNunber', this.documentNunber);
                formData.append('name', this.name);
                formData.append('email', this.email);
                formData.append('rolType', this.rolType.id);
                formData.append('position', this.position.id);
                formData.append('password', this.password );
                formData.append('file', this.file );
                 const config = {
                    headers: {'content-type': 'multipart/form-data'}
                };
                axios.post('/setUserNew', formData, config).then(response => {
                    this.modal_user = false;
                    let data = response.data;
                    if (data != null){
                        this.messageAlert('success', 'Buen trabajo!', 'Se ha creado exitosamente el usuario.');
                    }else {
                        this.messageAlert('info', 'Información', 'Algunos datos tuvieron conflito con el sistema. Intente de nuevo.');
                    }

                }).catch(e => {
                    console.log(e.response);
                });
            },  
        },
    };
</script>

<style scoped>
    .bg-gradient-success {
        background: linear-gradient(87deg, #8f141b 0, #8f141b 100%) !important;
    }

    .bg-secondary {
        background-color: #fff !important;
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

