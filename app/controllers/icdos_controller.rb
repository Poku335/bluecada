class IcdosController < ApplicationController
  before_action :set_icdo, only: %i[ show update destroy ]

  # GET /icdos
  # GET /icdos.json
  # def index
  #   @icdos = Icdo.all
  # end
  def index
    icdo_results = []
    keyword_counts = {}  # แฮชเพื่อเก็บจำนวนผลลัพธ์สำหรับแต่ละ keyword
    results = {}  # แฮชเพื่อเก็บผลลัพธ์และจำนวนผลลัพธ์
    
    if params[:paragraph].present?
      # แยกคำโดยเฉพาะคำที่เป็นตัวอักษรและเลขที่มีความหมาย
      keywords = params[:paragraph].scan(/\b\w+\b/).map(&:downcase)
      keywords.each do |keyword|
        original_keyword = keyword.strip
        
        # ข้ามการค้นหาหาก keyword เป็นคำที่ไม่ต้องการ
        next if %w[differentiation u s g pap low cyst os p disease situ 21 like d i n c side m re b or invasive cap neu per small ca 3a system form forms ni an be polyp acute mixed 22 non diffuse mid man nodule moderate round 14 stroma black type 16 features showing nodular pe show gh on marked tan ia node tissue olig negative red feature clear fibrous gland gene benign site nest margin 6 from deep lesion iii ii v 12 9 17 8 va lymph 4 border 5 x no not differentiated single 3 all between a for at well pr 11 r of 2 1 er ki e t h and with as test cell o her in cut the grade high 19 chronic positive 15 is multiple].include?(original_keyword.downcase)
        
        # ค้นหาผลลัพธ์จาก keyword
        search_results = Icdo.search_by_paragraph(keyword)
        results_count = search_results.count
  
        # บันทึกจำนวนผลลัพธ์ลงในแฮช
        keyword_counts[keyword] = results_count if results_count > 0
  
        # แสดงจำนวนผลลัพธ์ที่ได้
        puts "results count for '#{keyword}': #{results_count}"
  
        if results_count < 25
          search_results.each do |result|
            icdo_results << result unless icdo_results.include?(result)
            results[keyword] = results_count if results_count > 0
          end
        end
      end
  
      combined_keywords = keywords.select { |kw| keyword_counts[kw] && keyword_counts[kw] > 25 }
      if combined_keywords.any?
        used_keywords = []
  
        combined_keywords.each_slice(3) do |keyword_group|
          # รวมคำในกลุ่ม
          combined_keyword_string = keyword_group.join(' ')
  
          # ลบคำที่ซ้ำกันใน combined_keyword_string
          unique_combined_keywords = combined_keyword_string.split.uniq.join(' ')
  
          # ค้นหาผลลัพธ์ใหม่โดยใช้คำที่ไม่ซ้ำกัน
          combined_results = Icdo.search_by_paragraph(unique_combined_keywords)
          combined_results_count = combined_results.count
          if combined_results_count <=25
            combined_results.each do |result|
              icdo_results << result unless icdo_results.include?(result)
              results_count = combined_results.count
              results[unique_combined_keywords] = results_count if results_count > 0
            end
          end
          # แสดงผลลัพธ์ของคำที่ถูกบวกกัน
          puts "Further combined search results for: #{unique_combined_keywords}"
          puts "Total further combined results count: #{combined_results.count}"
  
          # เพิ่มคำที่รวมไปยัง used_keywords
          used_keywords.concat(unique_combined_keywords.split)
        end
      end
    else
      # หากไม่มีพารากราฟ ให้ดึงข้อมูลทั้งหมด
      icdo_results = Icdo.all.to_a
    end
  
    # แสดงจำนวนผลลัพธ์สุดท้าย
    puts "Total icdo_results count: #{icdo_results.count}"
    
    # แสดงผลจำนวนผลลัพธ์ของแต่ละ keyword ที่มีจำนวนผลลัพธ์มากกว่า 0
    puts "Results_count: #{results}"
    # ส่งผลลัพธ์กลับ
    render json: icdo_results
  end
  

  # GET /icdos/1
  # GET /icdos/1.json
  def show
  end

  # POST /icdos
  # POST /icdos.json
  def create
    @icdo = Icdo.new(icdo_params)

    if @icdo.save
      render :show, status: :created, location: @icdo
    else
      render json: @icdo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /icdos/1
  # PATCH/PUT /icdos/1.json
  def update
    if @icdo.update(icdo_params)
      render :show, status: :ok, location: @icdo
    else
      render json: @icdo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /icdos/1
  # DELETE /icdos/1.json
  def destroy
    @icdo.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_icdo
      @icdo = Icdo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def icdo_params
      params.require(:icdo).permit(:idd, :beh, :cancer_type, :icdo_32, :icdo_32_c, :level, :term_used, :term_raw)
    end
end
