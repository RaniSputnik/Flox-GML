// scrOnQueryError(String error, Real httpStatus)


self.error = argument0;

with self.loadingIndicator instance_destroy();
if ds_exists(self.results,ds_type_list) {
    ds_list_destroy(self.results);
}
self.results = noone;
