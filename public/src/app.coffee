angular.module("App", ['ngResource'])
    .factory('Product', ($resource) ->
        $resource('products/:idProduct', {idProduct: '@id'}, {
            update: {method: 'PUT'}
        })
    )
    .controller("ProductsCtrl", ['$scope', '$http', 'Product', ($scope, $http, Product) ->
        $scope.newProduct = new Product()
        reloadProducts = -> Product.query({}, (data) -> $scope.products = data)
        reloadProducts()
        $scope.submit = ->
            $scope.newProduct.$save((savedProduct, responseHeaders) ->
                $scope.message = "New Product #{savedProduct.id} Added"
                $scope.newProduct = new Product()
                reloadProducts()
            , (response) ->
                console.log(response)
                $scope.message = ""
                $scope.errors = response.data.errors;
            )
            false

        $scope.updatePurchased = (productToUpdate) ->
            productToUpdate.purchased = !productToUpdate.purchased
            productToUpdate.$update((up, rh) ->
                $scope.message = "Product #{up.id} Updated"
                reloadProducts()
            , (response) ->
                console.log(response)
                $scope.message = ""
                $scope.errors = response.data.errors;
            )

        $scope.delete = (productToDelete) ->
            productToDelete.$delete((dp, rh) ->
                $scope.message = "Product #{dp.id} Deleted"
                reloadProducts()
            , (response) ->
                console.log(response)
                $scope.message = response.data.message;   
            )
    ])