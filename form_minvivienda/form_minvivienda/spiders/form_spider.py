import scrapy

class FormSpider(scrapy.Spider):
    name = 'form'
    start_urls = ['https://subsidiosfonvivienda.minvivienda.gov.co/micasaya/']
    cedulas = ["1026305231", "12995532"]

    def parse(self, response):
        tipo_documento_name = response.css('select[name="tipo_documento"]::attr(name)').get()
        numero_documento_name = response.css('input[name="numero_documento"]::attr(name)').get()

        for cedula in self.cedulas:
            form_data = {   
                         tipo_documento_name: '1',
                         numero_documento_name: cedula 
                         }

            yield scrapy.FormRequest.from_response(
                    response,
                    formdata=form_data,
                    callback=self.parse_results,
                    meta={'cedula': cedula}
                    )


    def parse_results(self, response):
        cedula = response.meta["cedula"]
        response = response.json()
        title = response["sweet"]["title"]
        if "NO POSTULADO" in title:
            yield {"cedula": cedula, "value": False}
        else:
            yield {"cedula": cedula, "value": True}
