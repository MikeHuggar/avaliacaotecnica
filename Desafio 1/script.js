//Object class to be parsed as the output file.
class Order {
    constructor() {
        this.pedidos = [];
    }
}

//An ordem item, which makes up the Order object's array.
class OrderItem {
    constructor(pedido_id) {
        this.pedido_id = pedido_id;
        this.caixas = [];
    }
}

//As suggested by the name, BoxContent represents the contents of a box, along with its ID.
class BoxContent {
    constructor (id){
        this.caixa_id = id;
        this.produtos = [];
    }
}

/* Three-dimensional boxes with a volume attribute, which is 
not present in the proposed challenge but needed for the solution. */
class Box {
    constructor(nome, altura, largura, comprimento) {
        this.nome = nome;
        this.altura = altura;
        this.largura = largura;
        this.comprimento = comprimento;
        this.volume = altura*largura*comprimento;
    }
}

// Boxes available in Mr. Manuel's stock.
const boxes = [
    new Box("Caixa 1", 30, 40, 80),
    new Box("Caixa 2", 80, 50, 40),
    new Box("Caixa 3", 50, 80, 60)
];

/* The box arrays are, coincidentally, already sorted by their volume in an ascending manner.
This means that the .sort() function is unnecessary for this example, but for good practice i reckon it's
a good idea to keep it in case different boxes were to be introduced/rearranged, hypothetically. */
boxes.sort((a, b) => a.volume - b.volume);

const inputFile = document.getElementById("inputFile");
const outputFile = document.getElementById("outputFile");

//Fires off when input value is changed, i.e. a file in sent by the user.
inputFile.addEventListener("change", fileHandler);

function fileHandler(event) {
    //File sent by the user.
    const file = event.target.files[0];

    const reader = new FileReader();

    //The "load" event makes sure the entire process follows through only when the files is successfully read.
    reader.addEventListener("load", () => {
        //Parses the entry JSON file, if it was read successfully.
        const data = JSON.parse(reader.result);
        const outputOrder = new Order();
        const fragmentOrders = data.pedidos;
        const fragmentOrderLength = fragmentOrders.length;
        for (let p = 0; p < fragmentOrderLength; p++) {
            const pedido = fragmentOrders[p];
            const orderLenght = pedido.produtos.length;
            //Adds an order to the output object.
            outputOrder.pedidos.push(new OrderItem(pedido.pedido_id));
            //Since in the entry JSON file the products have no volume, we have to give them one here.
            calculateVolume(pedido.produtos);
            //Array for the boxes already in use in this particular order.
            let currentBoxes =  [];
            for (let i = 0; i < orderLenght; i++) {
                const produto = pedido.produtos[i];
                //Every product starts not fitting in any box.
                let fits = false;

                //If the product can fit in one of the boxes already in the order, we put it there...
                if (currentBoxes.length > 0) {
                    for (let k = 0; k < currentBoxes.length; k++) {
                        if (fitsOnBox(currentBoxes[k], produto)) {
                            subtractSpace(currentBoxes[k],produto);
                            outputOrder.pedidos[p].caixas[outputOrder.pedidos[p].caixas.length - 1].produtos.push(produto.produto_id);
                            fits = true;
                        }
                    }
                }
                //...and if it can't, we see if it fits in any of the available boxes.
                if (!fits) {
                    for (let j = 0; j < boxes.length; j++) {
                        //We clone the stock's boxes as to not alter their values.
                        const newBox = cloneBox(boxes[j])
                        if (fitsOnBox(newBox, produto)) {
                            subtractSpace(newBox, produto);
                            currentBoxes.push(newBox);
                            outputOrder.pedidos[p].caixas.push(new BoxContent(newBox.nome));
                            outputOrder.pedidos[p].caixas[outputOrder.pedidos[p].caixas.length - 1].produtos.push(produto.produto_id);
                            fits = true;
                            break;
                        }
                    }
                }
                //If the product(s) can't fit in any box whatsoever, we add an observation informing the user.
                if (!fits) {
                    outputOrder.pedidos[p].caixas.push(new BoxContent(null));
                    outputOrder.pedidos[p].caixas[outputOrder.pedidos[p].caixas.length - 1].produtos.push(produto.produto_id);
                    outputOrder.pedidos[p].caixas[outputOrder.pedidos[p].caixas.length - 1].observacao = "Produto não cabe em nenhuma caixa disponível.";
                }
            }
        }
        outputFile.textContent = JSON.stringify(outputOrder, null, 2);
        
        //Creates a blob with the output's content.
        const blob = new Blob([outputFile.textContent], {type: "application/json"});
        //Creates a link for the blob and an <a> element in the document.
        const url = URL.createObjectURL(blob);
        const link = document.createElement("a");
        //Adds link to the <a> element.
        link.href = url;
        link.download = "saida.json";
        //"Clicks" the link.
        link.click();
        //Removes the URL from memory since it's no longer needed.
        URL.revokeObjectURL(url);

    });

    //Prints the output file.
    reader.readAsText(file);
}


//All the functions have pretty self-explanatory names.

function calculateVolume(items) {
    const length = items.length;
    for (let i = 0; i < length; i++) {
        items[i].dimensoes.volume = items[i].dimensoes.altura*items[i].dimensoes.largura*items[i].dimensoes.comprimento;
    }
    items.sort((a, b) => b.dimensoes.volume - a.dimensoes.volume);
}

function fitsOnBox(box, item) {
    return (
        ((item.dimensoes.altura <= box.altura &&
        item.dimensoes.largura <= box.largura &&
        item.dimensoes.comprimento <= box.comprimento) ||
        (item.dimensoes.altura <= box.largura &&
        item.dimensoes.largura <= box.altura &&
        item.dimensoes.comprimento <= box.comprimento) ||
        (item.dimensoes.altura <= box.comprimento &&
        item.dimensoes.largura <= box.largura &&
        item.dimensoes.comprimento <= box.altura)) &&
        item.dimensoes.volume <= box.volume
    );
}

function cloneBox(box) {
    return new Box(box.nome, box.altura, box.largura, box.comprimento)
}

function subtractSpace(box, item) {
    box.volume -= item.dimensoes.volume;
}