// scrOnQueryComplete(List results)


if ds_exists(self.results,ds_type_list) {
    ds_list_destroy(self.results);
}
self.results = argument0;

with self.loadingIndicator instance_destroy();
