<template>
    <div>
        <base-header type="gradient-success" class="pb-6 pb-8 pt-5 pt-md-8">
        </base-header>
        <div class="container-fluid mt--7">
            <div class="row">
                <div class="col">
                    <div class="card shadow border-0">
                        <tabs>
                            <tab-pane title="UI/UX Design"></tab-pane>
                            <tab-pane title="Programming"></tab-pane>
                            <tab-pane title="Graphic"></tab-pane>
                        </tabs>
                    </div>
                </div>
            </div>
            <div class="row mt-5">
                <div class="col">
                    <tabs>
                        <tab-pane title="UI/UX Design"></tab-pane>
                        <tab-pane title="Programming"></tab-pane>
                        <tab-pane title="Graphic">
                            <div>
                                <b-button>Button</b-button>
                                <b-button variant="danger">Button</b-button>
                                <b-button variant="success">Button</b-button>
                                <b-button variant="outline-primary">Buton</b-button>
                            </div>
                        </tab-pane>
                    </tabs>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "Ejemplo",
    };
</script>

<style scoped>

</style>
